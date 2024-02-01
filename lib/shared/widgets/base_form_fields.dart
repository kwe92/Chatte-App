import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/shared/utils/classes/form_field_parameters.dart';
import 'package:chatapp/shared/utils/classes/form_field_validators.dart';
import 'package:flutter/material.dart';

class BaseFormFields extends StatelessWidget {
  final bool showUserNameField;
  final FormFieldParameters formFieldParameters;
  final FormFieldValidators formFieldValidators;

  const BaseFormFields({
    this.showUserNameField = true,
    required this.formFieldParameters,
    required this.formFieldValidators,
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
            controller: formFieldParameters.userNameController,
            keyboardType: TextInputType.text,
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
        TextFormField(
          controller: formFieldParameters.passwordController,
          onChanged: formFieldParameters.setPassword,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Password",
            hintText: "Enter Password",
          ),
          // Password field validator
          validator: formFieldValidators.passwordValidator,
        )
      ],
    );
  }
}
