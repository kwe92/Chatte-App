//TODO: Change animation upon navigation to a diffrent screen, right now it fades in kinda ugly
import 'package:chatapp/shared/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/features/authentication/ui/auth_view_model.dart';
import 'package:chatapp/features/authentication/ui/widgets/create_page_button.dart';
import 'package:chatapp/features/authentication/ui/widgets/login_button.dart';
import 'package:chatapp/shared/widgets/form_fields.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({required this.title, super.key});

  final String title;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) => BaseScaffold(
        body: ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
          builder: (context, child) {
            final model = Provider.of<AuthViewModel>(context);

            return Center(
              child: model.userFound
                  ? const CircularProgressIndicator.adaptive()
                  :
                  // Auth Form
                  Card(
                      margin: const EdgeInsets.all(12.0),
                      // Scrollable form
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          // Form start
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // UI error if the user is not found
                                model.userNotFound
                                    ? const Text(
                                        'Invalid username or password',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : const SizedBox(),
                                // Form Fields
                                FormFields(
                                    userNameController: model.userNameController,
                                    passwordController: model.passwordController,
                                    emailController: model.emailController),
                                gaph16,
                                //Login button
                                LoginButton(
                                  formKey: model.formKey,
                                  userNameController: model.userNameController,
                                  emailController: model.emailController,
                                  passwordController: model.passwordController,
                                  userNotFoundCallback: model.isValid,
                                  successCallback: model.successfulLogin,
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
          },
        ),
        title: widget.title,
        bgColor: Theme.of(context).colorScheme.background,
      );
}
