// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/features/authentication/ui/widgets/custom_switch.dart';
import 'package:chatapp/features/authentication/ui/widgets/horizontal_line.dart';
import 'package:chatapp/features/authentication/ui/widgets/social_media_icon_button.dart';
import 'package:chatapp/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/features/create_user/presentation/create_user_screen.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
import 'package:chatapp/shared/widgets/form_fields.dart';
import 'package:provider/provider.dart';

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
                gapH32,
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png'),
                    gapW16,
                    SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/facebook_icon.png'),
                    gapW16,
                    SocialMediaIconButton(iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/twitter_icon.png'),
                  ],
                ),
                gapH28,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HorizontalLine(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: AppColor.grey2,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    HorizontalLine(),
                  ],
                ),
                gapH16,
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
                            gapH24,
                            Row(
                              children: [
                                // TODO: add state in view model
                                CustomSwitch(
                                  value: true,
                                  onChanged: (value) {},
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.black0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            gapH36,
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
                            gapH32,
                            //Navigate to create account page
                            Row(
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.grey1,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
