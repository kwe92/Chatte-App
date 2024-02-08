import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_data.dart';
import '../../../setup/test_helpers.dart';

void main() {
  group("SignInViewModel", () {
    SignInViewModel getModel() => SignInViewModel();

    test("when set state methods called, states are changed", () {
      // Arrange = Setup

      final model = getModel();

      const email = "baki@grappler.io";

      const password = "Password11!!";

      const isSwitchedOn = true;

      // Act

      model.setEmail(email);

      model.setPassword(password);

      model.setSwitchState(isSwitchedOn);

      // Assert - Result

      expect(model.email, email);

      expect(model.password, password);

      expect(model.switchState, isSwitchedOn);
    });

    test('when clearData called, then all data cleared', () {
      // Arange - Setup

      final model = getModel();

      // Act

      model.setEmail(testUser.email);

      model.setPassword(testUser.password);

      model.emailController.text = testUser.email;

      model.passwordController.text = testUser.password;

      // Assert - Result

      expect(model.email, testUser.email);

      expect(model.emailController.text, testUser.email);

      expect(model.password, testUser.password);

      expect(model.passwordController.text, testUser.password);

      // Act

      model.clearData();

      // Assert - Result

      expect(model.email, '');

      expect(model.emailController.text, '');

      expect(model.password, '');

      expect(model.passwordController.text, '');
    });

    test('when createCurrentUser called, then current user is retrieved', () async {
      // Arrange - Setup

      getAndRegisterFirebaseService(
        email: testUser.email,
        password: testUser.password,
      );

      getAndRegisterUserService();

      final model = getModel();

      // Act

      final currentUser = await model.createCurrentUser();

      // Assert - Result

      verify(() => userService.getCurrentUser(CollectionPath.users.path, testUser.id)).called(1);
      verify(() => firebaseService.currentUser).called(1);

      expect(currentUser, testUser);
    });

    test("when email and password filled with registered user, then user signin is successful", () async {
      // Arrange = Setup

      getAndRegisterFirebaseService(
        email: testUser.email,
        password: testUser.password,
      );

      getAndRegisterUserService();

      final model = getModel();

      // Act

      model.setEmail(testUser.email);

      model.setPassword(testUser.password);

      await model.signInWithEmailAndPassword();

      // Assert - Result

      verify(() => firebaseService.signInWithEmailAndPassword(testUser.email, testUser.password)).called(1);
      verify(() => userService.getCurrentUser(CollectionPath.users.path, testUser.id)).called(1);
      verify(() => firebaseService.currentUser).called(1);
    });
  });
}
