import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }
}