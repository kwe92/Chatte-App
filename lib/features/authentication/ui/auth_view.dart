//TODO: Change animation upon navigation to a diffrent screen, right now it fades in kinda ugly
// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/features/create_user/presentation/create_user_screen.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/features/authentication/ui/auth_view_model.dart';
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
              child:
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
                          // Form Fields
                          FormFields(
                            userNameController: model.userNameController,
                            passwordController: model.passwordController,
                            emailController: model.emailController,
                          ),
                          gaph16,
                          //Login button
                          SizedBox(
                            width: 400,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (Validator.trySubmit(model.formKey)) {
                                  var error = await model.signInWithEmailAndPassword();

                                  if (error == null) {
                                    // Currently logged in user data
                                    final currentUser = await model.createCurrentUser();

                                    await appNavigator.push(
                                      context,
                                      (context) => ChatScreen(currentUser: currentUser),
                                    );

                                    model.clearControllers();
                                  }
                                  // TODO: snackbar UI error if the user is not found
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ),

                          //Navigate to create account page
                          TextButton(
                            onPressed: () => appNavigator.pushReplacement(
                              context,
                              (context) => const CreateScreen(),
                            ),
                            child: const Text('Sign Up'),
                          ),
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
