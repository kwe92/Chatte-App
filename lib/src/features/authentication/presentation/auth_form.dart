import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/authentication/presentation/create_page_button.dart';
import 'package:chatapp/src/features/authentication/presentation/login_button.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //The form key is used to validate the form
  final _formKey = GlobalKey<FormState>();

  bool _userNotFound = false;
  bool _userFound = false;

// callback to handle user not found
  void _isValid(bool valid) => setState(() {
        _userNotFound = valid;
      });
// callback to handle successful login
  void _successfulLogin(bool successful) => setState(() {
        _userFound = successful;
      });

  @override
  Widget build(BuildContext context) {
    // Controllers
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    // Auth Form
    return Center(
      child: _userFound
          ? const CircularProgressIndicator.adaptive()
          : Card(
              margin: const EdgeInsets.all(12.0),
              // Scrollable form
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  // Form start
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // UI error if the user is not found
                        _userNotFound
                            ? const Text(
                                'Invalid username or password',
                                style: TextStyle(color: Colors.red),
                              )
                            : const SizedBox(),
                        // Form Fields
                        FormFields(
                            userNameController: userNameController,
                            passwordController: passwordController,
                            emailController: emailController),
                        gaph16,
                        //Login button
                        LoginButton(
                          formKey: _formKey,
                          userNameController: userNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          userNotFoundCallback: _isValid,
                          successCallback: _successfulLogin,
                        ),

                        //Navigate to create account page
                        const ToCreatePageButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
