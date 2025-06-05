import 'dart:convert';

import 'package:flutterlearn/core/apiData.dart';
import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:http/http.dart' as http;

class HomePostService {
  final HomeModel _homeModel = HomeModel();

  HomeModel get homePostData => _homeModel;

  Future<HomeModel?> createHomeService(
    String homeName,
    String userId,
    double homeLongitude,
    double homeLatitude,
  ) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      _homeModel.homeName = homeName;
      _homeModel.userId = userId;
      _homeModel.homeLongitude = homeLongitude;
      _homeModel.homeLatitude = homeLatitude;

      final url = Uri.parse("$endpoint/homes");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(_homeModel.toJson()),
      );

      if (response.statusCode == 201) {
           _homeModel.statusCode = response.statusCode;
        print("Server response: ${response.body}");

      }

    } catch (e) {

    }
    return null;
  }
}
