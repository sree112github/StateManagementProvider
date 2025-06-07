import 'dart:convert';
import 'dart:developer';
import 'package:flutterlearn/core/apiData.dart';
import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:flutterlearn/data/model/MixedModels/HomeResponseModel.dart';
import 'package:http/http.dart' as http;

class HomeGetService {

  final HomeModel _homeModel = HomeModel();


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


  Future<HomeResponseModelMix?> getHomeAverageService() async {
    try {
      final url = Uri.parse(
        "$endpoint/homes/05f7604d-787e-4f28-becb-58026afdec70/averages",
      );

      final response = await http.get(url);
      log("📦 Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final homeAverageData = HomeResponseModelMix.fromJson(responseData);

        log("✅ Successfully fetched home averages");
        return homeAverageData;
      } else {
        log("❌ Failed to fetch: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("💥 Exception occurred: $e");
      return null;
    }
  }




}
