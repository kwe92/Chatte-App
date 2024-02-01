import 'dart:io';
import 'package:chatapp/app/resources/reusables.dart';
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
  // Get picture from users gallery
  Future<File?> _imagePicker() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    return File(pickedImageFile!.path);
  }

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage == null ? null : FileImage(pickedImage!),
        ),
        gapH4,
        TextButton.icon(
          onPressed: () async {
            final File? result = await _imagePicker();
            // print('IMGAGE: ${result.toString()}');
            setState(() {
              pickedImage = result;
            });
            // Return the picked image information to the create form
            widget.callback(result);
          },
          icon: const Icon(Icons.image),
          label: const Text('Add an image'),
        )
      ],
    );
  }
}
