import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:zaykazone/model/users/user_model.dart';
import 'package:zaykazone/utils/constants/constants.dart';

class AuthApiService {

  static Future<UserModel?> UserPostData(String name,String email,String mobile,ImagePicker image) async{
    final response=await http.post(Uri.parse(AppConstants.baseUrl));
  }
}