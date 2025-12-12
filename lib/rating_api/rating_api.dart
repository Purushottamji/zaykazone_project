// import 'dart:convert';
//
// import 'package:zaykazone/rating_model/rating_model.dart';
// import 'package:http/http.dart'as http;
//
// class RatingApi {
// static Future<List<RatingModel>?>getRatingDetails(int user_id)async{
//   var res=await http.get(Uri.parse("https://zaykazone-project-api.onrender.com/rating/$user_id"));
//   if(res.statusCode==200){
//     var resBody=res.body;
//     List<dynamic>json=jsonDecode(resBody);
//     var convertModel=json.map((e) => RatingModel.jsonToRatingModel(e),).toList();
//     return convertModel;
//
//   }
//   return null;
//
// }
// }
//
//



import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../rating_model/rating_model.dart';

class RatingApi {
  static int storeId=0;

  static Future<int?> storeUserId(BuildContext context) async {
    var data= Provider.of<LoginProvider>(context,listen: false).userData;
    if(data!=null){
      storeId=data["user_id"];
    }
    return storeId;
  }

  /// GET ALL REVIEWS
  static Future<List<RatingModel>?> getRatingDetails(int userId) async {
    try {
      final response = await http.get(
        Uri.parse("https://zaykazone-project-api.onrender.com/rating/$userId"),
      );
      print("GET REVIEW RESPONSE → ${response.body}");

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => RatingModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Get Rating Error: $e");
    }
    return null;
  }

  /// ADD REVIEW
  static Future<RatingModel?> addReview({
    required int userId,
    required int res_id,
    required String productName,
    required double rating,
    required String experience,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("https://zaykazone-project-api.onrender.com/add_data/$userId"),
        body: {
          "res_id": res_id.toString(),
          "product_name": productName,
          "rating": rating.toString(),
          "experience": experience,
        },
      );

      print("ADD REVIEW RESPONSE → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var res = jsonDecode(response.body);
        return RatingModel.fromJson(res);
      }
    } catch (e) {
      print("Add Rating Error: $e");
    }

    return null;
  }

  /// DELETE REVIEW
  static Future<bool> deleteRating(int id) async {
    try {
      final url = Uri.parse(
        "https://zaykazone-project-api.onrender.com/delete_data/$id",
      );

      final response = await http.delete(url);

      print("DELETE RESPONSE → ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Delete Rating Error: $e");
      return false;
    }
  }

}
