import 'dart:convert';
import 'dart:io';
import 'package:aqar360/app/core/errors/image_upload_exception.dart';
import 'package:http/http.dart' as http;

class ApiServer {
  static const String _baseUrl = "https://api.imgbb.com/1/upload";
  static const String _apiKey = "96f08997ff91fa8ed2b9cea1a04d2c77";

  static Future<String> getLinkImage(File imageFile) async {
    final url = Uri.parse("$_baseUrl?key=$_apiKey");

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(url, body: {"image": base64Image});

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final imageUrl = data["data"]["url"];

        if (imageUrl == null) {
          throw ImageUploadException("Image URL not found in response");
        }

        return imageUrl;
      } else {
        throw ImageUploadException(
          data["error"]?["message"] ?? "Upload failed",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ImageUploadException("Unexpected error: $e");
    }
  }
}
