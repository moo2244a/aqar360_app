import 'dart:io';

import 'package:aqar360/app/core/network/api_server.dart';
import 'package:image_picker/image_picker.dart';

class AddImageUseCase {
  static Future<String?> call() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);
      return await ApiServer.getLinkImage(file);
    }
    return null;
  }
}
