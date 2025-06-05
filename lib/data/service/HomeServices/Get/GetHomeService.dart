import 'dart:convert';
import 'package:flutterlearn/core/apiData.dart';
import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:http/http.dart' as http;

class HomeGetService {

  HomeModel _homeModel = HomeModel(null, null, 0.0, 0.0, null, null);


  Future<List<HomeModel>?> getAllHomeInfo(String userId) async {
    try {
      var url = Uri.parse("$endpoint/homes/$userId");
      print("the userId is: $userId");

      await Future.delayed(Duration(seconds: 3)); // Simulated loading delay
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("The response body is : ${response.body}");

        _homeModel.statusCode = response.statusCode;

        final decoded = jsonDecode(response.body);

        final homeResponse = HomeResponseModel.fromJson(decoded);

        print("the homereposnse is : ${homeResponse.data}");


        return homeResponse.data;
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }
}
