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

      final loginButton = find.text("Login");

      expect(loginButton, findsOneWidget);
    });
  });

  testWidgets("when login button pressed and text fields are empty, error text received and navigation to ChatView doesn't happen",
      (tester) async {
    await pumpView<SignInViewModel>(
      tester,
      view: const SignInView(),
      viewModel: SignInViewModel(),
    );

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
}
