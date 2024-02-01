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

// TODO: implement confirm password

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      builder: (context, _) {
        final model = Provider.of<SignUpViewModel>(context);

        return Scaffold(
          body: model.isBusy
              ? const CircularProgressIndicator.adaptive()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 56,
                      right: 24,
                    ),
                    child: Column(
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
                                  gapH32,
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: UserImageSection(),
                            ),
                          ],
                        ),
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
                                // TODO: use mutable variables instead of controllers to handle text form field using onChanged
                                formFieldParameters: FormFieldParameters(
                                  userNameController: model.userNameController,
                                  passwordController: model.passwordController,
                                  emailController: model.emailController,
                                ),
                                formFieldValidators: FormFieldValidators(
                                  emailValidator: stringService.emptyEmailValidator,
                                  userNameValidator: stringService.userNameValidator,
                                  passwordValidator: stringService.passwordValidator,
                                ),
                              ),
                              gapH16,
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
                              gapH12,

                              MainButton(
                                onPressed: () async {
                                  if (model.pickedImage == null) {
                                    model.setIsImagePicked(false);
                                    return;
                                  }

                                  if (Validator.trySubmit(model.formKey)) {
                                    final (currentUser, error) = await model.createUserInFirebase();

                                    if (error != null) {
                                      toastService.showSnackBar(context, error.toString());
                                      return;
                                    }

                                    await appNavigator.pushReplacement(
                                      context,
                                      (context) => ChatScreen(
                                        currentUser: currentUser!,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                              gapH12,
                              CustomTextButton(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () async => await appNavigator.pushReplacement(
                                  context,
                                  (context) => const SignInView(),
                                ),
                                child: const Text('I already have an account'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
