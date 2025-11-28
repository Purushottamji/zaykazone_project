import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zaykazone/model/users/user_model.dart';
import 'package:zaykazone/utils/constants/constants.dart';

class ApiService {

  static const String registerUrl = "${AppConstants.baseUrl}/auth/register";

  static Future<bool> registerApi({
    required String name,
    required String email,
    required String phone,
    required String password,
    File? imageFile,
  }) async {
    try {
      var uri = Uri.parse(registerUrl);
      var request = http.MultipartRequest("POST", uri);

      request.fields["name"] = name;
      request.fields["email"] = email;
      request.fields["password"] = password;
      request.fields["mobile"] = phone;

      // for image
      if (imageFile != null) {
        String fileExtension = imageFile.path.split('.').last.toLowerCase();

        // image type
        String mimeType = "jpeg"; // default

        if (fileExtension == "png") mimeType = "png";
        if (fileExtension == "jpg") mimeType = "jpeg";
        if (fileExtension == "jpeg") mimeType = "jpeg";
        if (fileExtension == "webp") mimeType = "webp";

        request.files.add(
          await http.MultipartFile.fromPath(
            "user_pic",
            imageFile.path,
            contentType: MediaType("image", mimeType),
          ),
        );
      }

      var response = await request.send();
      var body = await response.stream.bytesToString();

      print("STATUS: ${response.statusCode}");
      print("BODY: $body");

      return response.statusCode == 201;
    } catch (e) {
      print("Register API Error: $e");
      return false;
    }
  }

  static const String loginUrl = "${AppConstants.baseUrl}/auth/login";

  static Future<Map<String, dynamic>?> loginApi({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(loginUrl),
        body: {
          "email": email,
          "password": password,
        },
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Login API Error: $e");
      return null;
    }
  }

}
