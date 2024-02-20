import 'package:chatapp/features/authentication/ui/sign_in_view.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../setup/test_helpers.dart';

void main() {
  group("SignInView -", () {
    setUpAll(() async => registerSharedServices());

    testWidgets("when SignInView loaded, then find login text", (tester) async {
      await pumpView<SignInViewModel>(
        tester,
        view: const SignInView(),
        viewModel: SignInViewModel(),
      );

      await tester.pumpAndSettle();

      final loginButton = find.text("Login");

      expect(loginButton, findsOneWidget);
    });

    testWidgets("when login button pressed and text fields are empty, error text received and navigation to ChatView doesn't happen",
        (tester) async {
      await pumpView<SignInViewModel>(
        tester,
        view: const SignInView(),
        viewModel: SignInViewModel(),
      );

      await tester.pumpAndSettle();

      final loginButton = find.text("Login");

      final scaffoldFinder = find.byType(Scaffold);

      expect(loginButton, findsOneWidget);

      expect(scaffoldFinder, findsOneWidget);

      await tester.dragUntilVisible(
        loginButton,
        scaffoldFinder,
        const Offset(0, 200),
      );

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      final emailErrorText = find.text("Email can not be empty.");

      expect(emailErrorText, findsOneWidget);

      expect(loginButton, findsOneWidget);
    });

    // testWidgets(
    //   "when valid email and password filled in and log in button pressed, then user navigates to the ChatView",
    //   (tester) async {
    //     getAndRegisterFirebaseService(
    //       email: testUser.email,
    //       password: testUser.password,
    //     );
    //     final model = SignInViewModel();
    //     await pumpView<SignInViewModel>(
    //       tester,
    //       view: const SignInView(),
    //       viewModel: model,
    //     );

    //     final loginButtonFinder = find.text("Login");

    //     final scaffoldFinder = find.byType(Scaffold);

    //     final emailFinder = find.byKey(keyService.emailKey);

    //     final passwordFinder = find.byKey(keyService.passwordKey);

    //     expect(
    //       loginButtonFinder,
    //       findsOneWidget,
    //     );

    //     expect(
    //       scaffoldFinder,
    //       findsOneWidget,
    //     );

    //     expect(
    //       emailFinder,
    //       findsOneWidget,
    //     );

    //     expect(
    //       passwordFinder,
    //       findsOneWidget,
    //     );

    //     model.setEmail(testUser.email);

    //     model.setPassword(testUser.password);

    //     await tester.enterText(emailFinder, testUser.email);

    //     await tester.enterText(passwordFinder, testUser.password);

    //     await tester.dragUntilVisible(
    //       loginButtonFinder,
    //       scaffoldFinder,
    //       const Offset(0, 200),
    //     );

    //     await tester.tap(loginButtonFinder);

    //     await tester.pumpAndSettle();
    //   },
    // );
  });
}
