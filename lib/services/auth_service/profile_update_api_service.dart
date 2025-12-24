import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../utils/constants/constants.dart';

class ProfileUpdateApiService {
  static Future<Map<String, dynamic>?> updateUser({
    required String id,
     String? name,
     String? email,
     String? mobile,
     String? bio,
    File? image,
  }) async {
    try {
      var url = Uri.parse("${AppConstants.baseUrl}/users/patch/$id");

      var request = http.MultipartRequest("PATCH", url);

     if(name!=null) request.fields['name'] = name;
      if(email!=null) request.fields['email'] = email;
      if(mobile!=null) request.fields['mobile'] = mobile;
      if(bio!=null) request.fields['user_bio'] = bio;

      if (image != null) {
        String fileExtension = image.path.split('.').last.toLowerCase();

        String mimeType = "jpeg";

        if (fileExtension == "png") mimeType = "png";
        if (fileExtension == "jpg") mimeType = "jpeg";
        if (fileExtension == "jpeg") mimeType = "jpeg";
        if (fileExtension == "webp") mimeType = "webp";

        request.files.add(
          await http.MultipartFile.fromPath(
            "user_pic",
            image.path,
            contentType: MediaType("image", mimeType),
          ),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("STATUS: ${response.statusCode}");
      print("BODY: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseBody);
      } else {
        return {
          "success": false,
          "message": "Update failed",
          "body": responseBody
        };
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
