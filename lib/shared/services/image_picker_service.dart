import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImagePickerService {
  /// Retrieve picture from users gallery.
  Future<(File?, bool, String?)> pickImage() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    try {
      final pickedImageFile = await picker.getImageFromSource(
        source: ImageSource.gallery,
        options: const ImagePickerOptions(
          imageQuality: 50,
          maxWidth: 150,
        ),
      );

      debugPrint('pickedImageFile: $pickedImageFile');

      if (pickedImageFile == null) {
        return (null, false, null);
      }

      return (File(pickedImageFile.path), true, null);
    } catch (e) {
      debugPrint('exception in pickImage: ${e.toString()}');
      return (null, false, e.toString());
    }
  }
}
