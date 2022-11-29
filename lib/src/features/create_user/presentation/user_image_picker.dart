import 'dart:io';

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/material.dart';

typedef ImageFileCallback = void Function(File? imageFile);

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({required this.callback, super.key});

  final ImageFileCallback callback;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  Future<File?> _imagePicker() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    final pickedImageFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    return File(pickedImageFile!.path);
  }

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pickedImage == null
            ? const CircularProgressIndicator.adaptive()
            : CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(pickedImage!),
              ),
        gaph4,
        TextButton.icon(
          onPressed: () async {
            final File? result = await _imagePicker();
            // print('IMGAGE: ${result.toString()}');
            setState(() {
              pickedImage = result;
            });
            widget.callback(result);
          },
          icon: const Icon(Icons.image),
          label: const Text('Add an image'),
        )
      ],
    );
  }
}
