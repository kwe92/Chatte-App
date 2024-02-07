import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
