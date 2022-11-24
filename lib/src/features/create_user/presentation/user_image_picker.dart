import 'dart:io';

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  Future<File?> _imagePicker() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedImageFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    File? pickedImage;
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage == null ? null : FileImage(pickedImage),
        ),
        gaph4,
        TextButton.icon(
          onPressed: () async {
            pickedImage = await _imagePicker();
          },
          icon: const Icon(Icons.image),
          label: const Text('Add an image.'),
        )
      ],
    );
  }
}
