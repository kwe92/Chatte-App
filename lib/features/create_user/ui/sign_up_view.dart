// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view.dart';
import 'package:chatapp/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view_model.dart';
import 'package:chatapp/features/create_user/ui/widgets/user_image_section.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/form_field_parameters.dart';
import 'package:chatapp/shared/utils/classes/form_field_validators.dart';
import 'package:chatapp/shared/widgets/base_form_fields.dart';
import 'package:chatapp/shared/widgets/custom_text_button.dart';
import 'package:chatapp/shared/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      builder: (context, _) {
        final model = Provider.of<SignUpViewModel>(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 52,
              right: 24,
            ),
            child: Stack(
              children: [
                if (model.isBusy) paddedIndicator,
                Column(
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to Chatte',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              gapH8,
                              Text(
                                'Sign up to join',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.grey2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // gapH32,
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: UserImageSection(),
                        ),
                      ],
                    ),
                    gapH16,
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          Form(
                            key: model.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Error message if an image is not picked
                                !model.isImagePicked
                                    ? const Text(
                                        'image required',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : const SizedBox(),
                                BaseFormFields(
                                  showConfirmPasswordField: true,
                                  formFieldParameters: FormFieldParameters(
                                    userNameController: model.userNameController,
                                    passwordController: model.passwordController,
                                    emailController: model.emailController,
                                    setEmail: model.setEmail,
                                    setPassword: model.setPassword,
                                    setUsername: model.setUsername,
                                    setConfirmPassword: model.setConfirmPassword,
                                  ),
                                  formFieldValidators: FormFieldValidators(
                                    emailValidator: stringService.emptyEmailValidator,
                                    userNameValidator: stringService.userNameValidator,
                                    passwordValidator: stringService.passwordValidator,
                                  ),
                                ),
                                // gapH16,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          margin: const EdgeInsets.only(right: 6),
                          child: Checkbox(
                            value: model.isChecked,
                            onChanged: model.setIsChecked,
                          ),
                        ),
                        const Text("I agree to the:"),
                        CustomTextButton(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          onPressed: () {},
                          child: const Text("Terms of Service"),
                        )
                      ],
                    ),
                    gapH8,
                    MainButton(
                      onPressed: () async {
                        if (Validator.trySubmit(model.formKey) && model.isReadyToSignUp()) {
                          final currentUser = await model.createUserInFirebase();

                          if (currentUser != null) {
                            await appNavigator.pushReplacement(ChatScreen(currentUser: currentUser));
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    CustomTextButton(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      onPressed: () async => await appNavigator.pushReplacement(const SignInView()),
                      child: const Text('I already have an account'),
                    ),
                    gapH30,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
