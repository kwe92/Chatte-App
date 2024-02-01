import 'dart:io';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImagePickerService {
  /// Retrieve picture from users gallery.
  Future<File?> pickImage() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    // TODO: set another default image
    return File(pickedImageFile?.path ?? '/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png');
  }
}
