import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utils/constants/constants.dart';

class ProfileUpdateApiService {

  static Future<Map<String, dynamic>?> updateUser({
    required String id,
    required String name,
    required String email,
    required String mobile,
    String? bio,
    File? image,
  }) async {
    var url = Uri.parse("${AppConstants.baseUrl}/users/update/$id");

    var request = http.MultipartRequest("PUT", url);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobile'] = mobile;
    request.fields['bio'] = bio ?? "";

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('user_pic', image.path));
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      print("Update Failed: $responseBody");
      return null;
    }
  }
}
