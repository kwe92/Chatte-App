// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/features/authentication/ui/widgets/custom_switch.dart';
import 'package:chatapp/features/authentication/ui/widgets/horizontal_line.dart';
import 'package:chatapp/features/authentication/ui/widgets/social_media_icon_button.dart';
import 'package:chatapp/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/form_field_parameters.dart';
import 'package:chatapp/shared/utils/classes/form_field_validators.dart';
import 'package:chatapp/shared/widgets/base_form_fields.dart';
import 'package:chatapp/shared/widgets/custom_text_button.dart';
import 'package:chatapp/shared/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view_model.dart';
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
                    SocialMediaIconButton(
                      assetImageScale: 1.25,
                      iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png',
                    ),
                    gapW16,
                    SocialMediaIconButton(
                      iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/facebook_icon.png',
                    ),
                    gapW16,
                    SocialMediaIconButton(
                      isSVG: true,
                      svgImageScale: 0.75,
                      iconPath: '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/twitter_icon.svg',
                    ),
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
                          color: AppColor.grey3,
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
                            BaseFormFields(
                              showUserNameField: false,
                              formFieldParameters: FormFieldParameters(
                                emailController: model.emailController,
                                passwordController: model.passwordController,
                                setEmail: model.setEmail,
                                setPassword: model.setPassword,
                              ),
                              formFieldValidators: FormFieldValidators(
                                emailValidator: stringService.emptyEmailValidator,
                                passwordValidator: stringService.emptyPasswordValidator,
                              ),
                            ),
                            gapH24,
                            Row(
                              children: [
                                CustomSwitch(
                                  value: model.switchState,
                                  onChanged: model.setSwitchState,
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
                            gapH24,
                            //Login button

                            MainButton(
                              onPressed: () async {
                                if (Validator.trySubmit(model.formKey)) {
                                  var (currentUser, error) = await model.signInWithEmailAndPassword();

                                  if (error == null) {
                                    await appNavigator.push(
                                      context,
                                      (context) => ChatScreen(currentUser: currentUser!),
                                    );

                                    model.clearText();
                                    return;
                                  }
                                  toastService.showSnackBar(context, "invalid username or password, please try again.");
                                }
                              },
                              child: const Text('Login'),
                            ),
                            gapH24,
                            Row(
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.grey3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                CustomTextButton(
                                  onPressed: () => appNavigator.pushReplacement(
                                    context,
                                    (context) => const SignUpView(),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
