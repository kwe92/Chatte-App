import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view_model.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../setup/test_data.dart';
import '../../../setup/test_helpers.dart';

void main() {
  group("SignUpViewModel - ", () {
    SignUpViewModel getModel() => SignUpViewModel();

    setUpAll(() async => await registerSharedServices());

    test("when model created and setState methods called, then states are set", () {
      // Arrange - Setup

      getAndRegisterFirebaseService(
        email: testUser.email,
        password: testUser.password,
      );

      final model = getModel();

      // Act

      model.setConfirmPassword(testUser.password);
      // model.setCurrentUser(mockUserCredential);
      model.setEmail(testUser.email);
      model.setIsChecked(true);
      model.setIsImagePicked(true);
      model.setPassword(testUser.password);
      model.setPickedImage(testPickedImage);
      model.setUsername(testUser.username);

      // Assert - Result

      expect(model.isMatchingPassword, true);
      expect(model.isChecked, true);
      expect(model.isImagePicked, true);
      expect(model.pickedImage!.path, testPickedImage.path);
    });

    test("when pickImage called and there is an image picked, then an image is returned.", () async {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterImagePickerService();

      final model = getModel();

      // Act

      await model.pickImage();

      // Assert - Result

      expect(model.pickedImage!.path, testPickedImage.path);
    });

    test("when pickImage called and there is no image picked without an error, then no image is selected.", () async {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterImagePickerService(pickedImage: null, isImagePicked: false);

      final model = getModel();

      // Act

      await model.pickImage();

      // Assert - Result

      expect(model.pickedImage, null);
    });
    // TODO: maybe move to the view tests instead of the view model
    testWidgets("when pickImage called and there is an error, then the toast service displays the error", (tester) async {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      const errorMsg = ToastServiceErrorMessage.imageError;

      getAndRegisterImagePickerService(pickedImage: null, isImagePicked: false, error: errorMsg);

      final toastService = getAndRegisterToastService(errorMsg);

      final model = getModel();

      await pumpView(
        tester,
        view: const SignUpView(),
        viewModel: model,
      );

      // Act
      await model.pickImage();

      // Assert - Result

      verify(() => toastService.showSnackBar(errorMsg)).called(1);

      expect(model.pickedImage, null);
    });

    test("when image selected, terms aggreed upon and all text fields complete, then user is ready to be registered", () async {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterImagePickerService();

      final model = getModel();

      // Act

      await model.pickImage();
      model.setEmail(testUser.email);
      model.setPassword(testUser.password);
      model.setConfirmPassword(testUser.password);
      model.setUsername("rentaru");
      model.setIsChecked(true);

      // Assert - Result

      var actual = model.isReadyToSignUp();

      var expected = true;

      expect(actual, expected);
    });

    test("when doesUserNameExist true, then exception is thrown and snack bar error displayed.", () {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterToastService();

      getAndRegisterUserService();

      final model = getModel();

      // Act

      model.setUsername("gara");

      // Assert - Result

      expect(() => model.doesUserNameExist(), throwsA(isA<Exception>()));

      verify(() => toastService.showSnackBar(ToastServiceErrorMessage.unavailableUserNameError)).called(1);
    });

    test("when check error called and error is not null, then exception is thrown and snack bar error displayed.", () {
      // Arrange - Setup

      TestWidgetsFlutterBinding.ensureInitialized();

      final model = getModel();

      const errorMsg = "error during account creation";

      // Assert - Result

      expect(() => model.checkError(errorMsg), throwsA(isA<Exception>()));

      verify(() => toastService.showSnackBar(ToastServiceErrorMessage.accountCreationError)).called(1);
    });

    // test("when createUserInFirebase called, new user is registered", () async {
    //   // Arrange - Setup

    //   TestWidgetsFlutterBinding.ensureInitialized();

    //   getAndRegisterImagePickerService();

    //   final model = getModel();

    //   // Act

    //   await model.pickImage();
    //   model.setEmail(testUser.email);
    //   model.setPassword(testUser.password);
    //   model.setConfirmPassword(testUser.password);
    //   model.setUsername("rentaru");
    //   model.setIsChecked(true);

    //   // Assert - Result

    //   var actual = model.isReadyToSignUp();

    //   var expected = true;

    //   expect(actual, expected);
    // });
  });
}
