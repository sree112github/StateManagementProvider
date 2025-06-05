import 'dart:convert';

import 'package:flutterlearn/core/apiData.dart';
import 'package:flutterlearn/data/model/authModel.dart/authModel.dart';
import 'package:http/http.dart' as http;

class AuthGetServices {
  UserModel _userModel = UserModel("N/A", "N/A", "N/A", "N/A", "N/A", null, "N/A");

  UserModel get userData => _userModel;

  Future<UserModel?> getUserInfo(String userId) async {
    try {

      print("the userid is: $userId");
      final url = Uri.parse("$endpoint/users/$userId");

      await Future.delayed(Duration(seconds: 3));
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("the response is : ${response.body}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("the response is : ${responseData}");

        _userModel = UserModel.fromJson(responseData, message: "Success");

        return _userModel;
      } else {
        print("some error occur: ${response.statusCode}");
      }
    } catch (e) {
      _userModel.userCreationMessage = "Error: $e";
      print("Error during HTTP POST: $e");
    }
    return null;
  }
}
