import 'dart:convert';
import 'package:flutterlearn/core/apiData.dart';
import 'package:flutterlearn/data/model/authModel.dart/authModel.dart';
import 'package:http/http.dart' as http;

class AuthPostService {
  UserModel _userModel = UserModel();

  UserModel get userData => _userModel;

  Future<UserModel?> createUserService({required String userName, required String userPassword}) async {
    try {
      final url = Uri.parse("$endpoint/users");

      _userModel.userName = userName;
      _userModel.password = userPassword;

      print("the username is $userName, and password is : $userPassword");

     await Future.delayed(Duration(seconds: 3));
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(_userModel.toJson()),
      );

      if (response.statusCode == 201) {
        print("Server response: ${response.body}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print("the response data is : $responseData");
        _userModel = UserModel.fromJson(responseData, message: "Success");

        // Set the message on the new instance
        // _userModel.userCreationMessage = "Success";

        return _userModel;  // Return updated model with message
      }
      else {
        _userModel.userCreationMessage = "Failed: ${response.statusCode}";
        print("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      _userModel.userCreationMessage = "Error: $e";
      print("Error during HTTP POST: $e");
    }
    return null;  // Return null only if failed or error
  }

}
