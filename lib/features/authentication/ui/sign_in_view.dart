//TODO: Change animation upon navigation to a diffrent screen, right now it fades in kinda ugly
// ignore_for_file: use_build_context_synchronously

// TODO: see what dependancies can be removed
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/features/create_user/presentation/create_user_screen.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
import 'package:chatapp/shared/widgets/form_fields.dart';
import 'package:provider/provider.dart';

// TODO: Refactor widget to make it smaller

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => SignInViewModel(),
        builder: (context, child) {
          final model = Provider.of<SignInViewModel>(context);

          return Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.only(
              left: 24,
              top: 72,
              right: 24,
            ),

            child: Column(
                // Scrollable form
                children: [
                  const Text(
                    'Login With',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png'),
                      SizedBox(width: 16),
                      SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/facebook_icon.png'),
                      SizedBox(width: 16),
                      SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/twitter_icon.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HorizontalLine(color: Color(0xffe1e1e1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Color(0xff858585),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      HorizontalLine(color: Color(0xffe1e1e1)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        // Form start
                        child: Form(
                          key: model.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Form Fields
                              FormFields(
                                showUserNameField: false,
                                passwordController: model.passwordController,
                                emailController: model.emailController,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  // TODO: add state in view model
                                  CustomSwitch(
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                  // const SizedBox(width: 2),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff262626),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 36),
                              //Login button
                              SizedBox(
                                width: double.maxFinite,
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
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 32,
                              ),

                              //Navigate to create account page
                              Row(
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff938886),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => appNavigator.pushReplacement(
                                      context,
                                      (context) => const CreateScreen(),
                                    ),
                                    child: const Text('Create Account'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}

class SocialMediaIconButton extends StatelessWidget {
  final String iconPath;

  const SocialMediaIconButton({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: add ink spash with inkwell
    return GestureDetector(
      onTap: () {
        // TODO: implement sign in feature based on what social media platform the user would like to use
      },
      child: Container(
        width: 76,
        height: 76,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffc5c5c5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  final Color color;

  final int flex;

  final double height;

  const HorizontalLine({
    required this.color,
    this.flex = 1,
    this.height = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: height,
        color: color,
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool value)? onChanged;
  const CustomSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.65,
      child: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
