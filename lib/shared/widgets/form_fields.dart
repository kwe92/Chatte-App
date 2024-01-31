import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  // TODO: use mutable variables and onChanged instead of controller text

  final TextEditingController? userNameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final bool showUserNameField;

  const FormFields({
    required this.passwordController,
    required this.emailController,
    this.showUserNameField = true,
    this.userNameController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const floatingTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xff121212),
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
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Email",
            hintText: "Enter Email",
          ),
          // Email field validator
          validator: emptyEmailValidator,
        ),

        // Username field
        if (showUserNameField) ...[
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Username",
            style: floatingTextStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: userNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Username",
              hintText: "Enter Username",
            ),
            // Username field validator
            validator: userNameValidator,
          ),
        ],
        const SizedBox(
          height: 24,
        ),
        const Text(
          "Password",
          style: floatingTextStyle,
        ),
        const SizedBox(
          height: 12,
        ),
        // Password field
        TextFormField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Password",
            hintText: "Enter Password",
          ),
          // Password field validator
          validator: passwordValidator,
        )
      ],
    );
  }
}

// TODO: the validators should be moved to a string service

String? emptyEmailValidator(value) {
  if (value == null) {
    return 'Email can not be empty.';
  }
  if (value.isEmpty || !value.contains('@') || value.contains(' ')) {
    return """
Email can not be empty
or contain spaces 
and must contain @.""";
  } else {
    return null;
  }
}

String? userNameValidator(value) {
  if (value!.length < 4) {
    return 'Username must be at least 4 characters.';
  }
  if (value.contains(RegExp(r'[^A-Za-z0-9]'))) {
    return 'Username can not contain special characters or spaces.';
  }
  return null;
}

String? passwordValidator(value) {
  if (value!.length < 7) {
    return 'Password must be at least 7 characters long.';
  }
  if (!value.contains(RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"))) {
    return r"""

Password Requirements:

  At least one:
    - digit
    - lowercase character
    - least uppercase character
    - least special character
  
  - least 8 - 32 characters in length.

""";
  }
  return null;
}
