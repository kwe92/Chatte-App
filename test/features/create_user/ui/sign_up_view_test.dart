import 'package:chatapp/features/create_user/ui/sign_up_view.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../setup/test_helpers.dart';

void main() {
  group('SignUpView - ', () {
    setUpAll(() async => await registerSharedServices());

    testWidgets('when SignUpView loaded, then sign up text is visible', (tester) async {
      await pumpView(
        tester,
        view: const SignUpView(),
        viewModel: SignUpViewModel(),
      );

      final signupTextFinder = find.text('Sign up to join');

      expect(signupTextFinder, findsOneWidget);
    });

    testWidgets('when have account text button clicked, then navigate to SignInView', (tester) async {
      await pumpView(
        tester,
        view: const SignUpView(),
        viewModel: SignUpViewModel(),
      );

      final haveAccountButton = find.textContaining("have an account");

      expect(haveAccountButton, findsOneWidget);

      await tester.tap(haveAccountButton);

      await tester.pumpAndSettle();

      final loginButton = find.text("Login");

      expect(loginButton, findsOneWidget);
    });

    testWidgets('when text fields are empty, then validators are activated stoping naviagation', (tester) async {
      await pumpView(
        tester,
        view: const SignUpView(),
        viewModel: SignUpViewModel(),
      );

      final submitButton = find.text("Submit");

      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);

      await tester.pumpAndSettle();

      final cantBeEmptyText = find.text("Email can not be empty.");

      expect(cantBeEmptyText, findsOneWidget);
    });

    testWidgets("when checkbox clicked, then box is checked", (tester) async {
      await pumpView(
        tester,
        view: const SignUpView(),
        viewModel: SignUpViewModel(),
      );

      final checkboxButton = find.byType(Checkbox);

      expect(checkboxButton, findsOneWidget);

      await tester.tap(checkboxButton);

      await tester.pumpAndSettle();
    });
  });
}
