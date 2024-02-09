import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/shared/controllers/password_visiblity_controller.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/form_field_parameters.dart';
import 'package:chatapp/shared/utils/classes/form_field_validators.dart';
import 'package:chatapp/shared/widgets/visibility_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseFormFields extends StatelessWidget {
  final bool showUserNameField;
  final bool showConfirmPasswordField;
  final FormFieldParameters formFieldParameters;
  final FormFieldValidators formFieldValidators;

  const BaseFormFields({
    required this.formFieldParameters,
    required this.formFieldValidators,
    this.showUserNameField = true,
    this.showConfirmPasswordField = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const floatingTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColor.black0,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Email field

        const Text(
          "Email",
          style: floatingTextStyle,
        ),
        gapH12,
        TextFormField(
          // key: keyService.emailKey,
          controller: formFieldParameters.emailController,
          onChanged: formFieldParameters.setEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Email",
            hintText: "Enter Email",
          ),
          // Email field validator
          validator: formFieldValidators.emailValidator,
        ),

        // Username field
        if (showUserNameField) ...[
          gapH24,
          const Text(
            "Username",
            style: floatingTextStyle,
          ),
          gapH12,
          TextFormField(
            // key: keyService.usernameKey,
            controller: formFieldParameters.userNameController,
            keyboardType: TextInputType.text,
            onChanged: formFieldParameters.setUsername,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Username",
              hintText: "Enter Username",
            ),
            // Username field validator
            validator: formFieldValidators.userNameValidator,
          ),
        ],
        gapH24,
        const Text(
          "Password",
          style: floatingTextStyle,
        ),
        gapH12,
        // Password field
        ...[
          ChangeNotifierProvider.value(
            value: passwordVisibilityController,
            builder: (context, _) {
              final bool isObscured = context.watch<PasswordVisibilityController>().isObscured;
              return Column(
                children: [
                  TextFormField(
                    // key: keyService.passwordKey,
                    controller: formFieldParameters.passwordController,
                    onChanged: formFieldParameters.setPassword,
                    obscureText: passwordVisibilityController.isObscured,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Password",
                      hintText: "Enter Password",
                      suffixIcon: VisibilityIcon(
                        isObscured: isObscured,
                        setObscurity: passwordVisibilityController.setIsObscured,
                      ),
                    ),
                    // Password field validator
                    validator: formFieldValidators.passwordValidator,
                  ),
                  // Password field
                  if (showConfirmPasswordField) ...[
                    gapH12,
                    TextFormField(
                      // key: keyService.confirmPasswordKey,
                      controller: formFieldParameters.conFirmPasswordController,
                      onChanged: formFieldParameters.setConfirmPassword,
                      obscureText: passwordVisibilityController.isObscured,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                        suffixIcon: VisibilityIcon(
                          isObscured: isObscured,
                          setObscurity: passwordVisibilityController.setIsObscured,
                        ),
                      ),
                      // Password field validator
                      validator: formFieldValidators.confirmPasswordValidator,
                    ),
                  ],
                ],
              );
            },
          )
        ],
      ],
    );
  }
}
