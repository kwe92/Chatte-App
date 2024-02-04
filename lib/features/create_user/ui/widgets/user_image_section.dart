import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/features/create_user/ui/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserImageSection extends StatelessWidget {
  const UserImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    const side = 30.0;

    final model = context.watch<SignUpViewModel>();
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColor.grey3.withOpacity(0.90),
          backgroundImage: model.pickedImage == null ? null : FileImage(model.pickedImage!),
        ),
        Positioned(
          top: 50,
          left: 50,
          child: GestureDetector(
            onTap: () async => await model.pickImage(),
            child: Container(
              height: side,
              width: side,
              decoration: const BoxDecoration(
                color: AppColor.primaryThemeColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(side / 2),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
        // gapH4,

   // TextButton.icon(
        //   onPressed: () async => model.pickImage(),
        //   icon: const Icon(Icons.image),
        //   label: const Text('Add an image'),
        // )
