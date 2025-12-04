import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants/constants.dart';

class ProfileUpdateApiService {
  static Future<Map<String, dynamic>?> updateUser({
    required String id,
     String? name,
     String? email,
     String? mobile,
    File? image,
  }) async {
    try {
      var url = Uri.parse("${AppConstants.baseUrl}/users/patch/$id");

      var request = http.MultipartRequest("PATCH", url);

     if(name!=null) request.fields['name'] = name;
      if(email!=null) request.fields['email'] = email;
      if(mobile!=null) request.fields['mobile'] = mobile;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('user_pic', image.path),
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
