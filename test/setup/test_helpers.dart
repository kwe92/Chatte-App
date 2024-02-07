import 'dart:async';
import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/app/navigation/app_navigator.dart';
import 'package:chatapp/shared/controllers/password_visiblity_controller.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/get_it.dart';
import 'package:chatapp/shared/services/image_picker_service.dart';
import 'package:chatapp/shared/services/key_service.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/services/string_service.dart';
import 'package:chatapp/shared/services/toast_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'test_data.dart';
import 'test_mocks.dart';

Future<void> registerSharedServices() async {
  // Clears all registered types in the reverse order in which they were registered.
  // Handy when writing unit tests or when disposing services that depend on each other.
  await locator.reset();
  getAndRegisterService<ToastService>(ToastService());
  getAndRegisterService<StringService>(StringService());
  getAndRegisterService<ImagePickerService>(ImagePickerService());
  getAndRegisterService<FireStoreService>(const FireStoreService());
  getAndRegisterService<UserService>(UserService());
  getAndRegisterService<PasswordVisibilityController>(PasswordVisibilityController());
  getAndRegisterService<AppNavigator>(AppNavigator());
  getAndRegisterService<KeyService>(KeyService());
}

T getAndRegisterService<T extends Object>(
  T service, {
  bool isSingleton = true,
  bool isLasySingleton = false,
}) {
  assert(T == service.runtimeType);

  _removeRegistrationIfExists<T>();

  if (isSingleton) {
    locator.registerSingleton<T>(service);
  } else if (isLasySingleton) {
    locator.registerLazySingleton<T>(() => service);
  } else {
    locator.registerFactory<T>(() => service);
  }

  return locator.get<T>();
}

FirebaseService getAndRegisterFirebaseService({
  required String email,
  required String password,
}) {
  _removeRegistrationIfExists<FirebaseService>();

  final FirebaseService service = MockFirebaseService();

  locator.registerSingleton<FirebaseService>(service);

  // method stubs

  when(() => service.signInWithEmailAndPassword(email, password)).thenAnswer(
    (_) async => await Future.value(null),
  );

  when(() => service.getUser(collectionPath: CollectionPath.users.path, userid: testUser.id)).thenAnswer(
    (_) async => await Future.value(
      mockDocumentSnapshot as FutureOr<DocumentSnapshot<Map<String, dynamic>>>,
    ),
  );

  when(() => service.currentUser).thenReturn(mockFirebaseUser);

  return service;
}

UserService getAndRegisterUserService() {
  _removeRegistrationIfExists<UserService>();

  final UserService service = MockUserService();

  locator.registerSingleton<UserService>(service);

  // method stubs

  when(() => service.getCurrentUser(CollectionPath.users.path, testUser.id)).thenAnswer(
    (_) async => await Future.value(testUser),
  );

  return service;
}

Future<void> _removeRegistrationIfExists<T extends Object>() async {
  if (locator.isRegistered<T>()) {
    await locator.unregister<T>();
  }
}

Future<void> pumpView<T extends ChangeNotifier>(WidgetTester tester, {required Widget view, T? viewModel}) async {
  await tester.pumpWidget(
    TestingWrapper<T>(
      view: view,
      viewModel: viewModel,
    ),
  );
}

class TestingWrapper<T extends ChangeNotifier> extends StatelessWidget {
  final Widget view;
  final T? viewModel;
  const TestingWrapper({
    required this.view,
    this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: keyService.navigatorKey,
      home: viewModel != null
          ? ChangeNotifierProvider<T>(
              create: (context) => viewModel!,
              builder: (context, _) => view,
            )
          : view,
    );
  }
}
