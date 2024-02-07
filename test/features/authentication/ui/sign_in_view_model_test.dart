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

    test("when email and password filled with registered user, then user signin is successful", () async {
      // Arrange = Setup

      final model = getModel();

      getAndRegisterFirebaseService(
        email: testUser.email,
        password: testUser.password,
      );

      getAndRegisterUserService();

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
