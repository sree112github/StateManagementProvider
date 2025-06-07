

import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:flutterlearn/data/model/LocationModel/locationModel.dart';
import 'package:flutterlearn/data/model/MixedModels/HomeResponseModel.dart';
import 'package:flutterlearn/data/service/HomeServices/Get/GetHomeService.dart';
import 'package:flutterlearn/data/service/HomeServices/Post/CreateHomePostService.dart';
import 'package:flutterlearn/data/service/LocationService/locationService.dart';

class HomeRepository{

  HomePostService _postService;
  HomeGetService _getService;
  LocationServices _locationServices;

  List<HomeModel> _homes = [];

  List<HomeModel> get homes => _homes;

  HomeRepository(this._postService,this._getService,this._locationServices);

  HomeModel get homePostData => _postService.homePostData;



  Future<void> createHome(homeName,userId,homeLongitude,homeLatitude) async{
     await _postService.createHomeService(homeName, userId, homeLongitude, homeLatitude);
  }

  Future<void> getHomeInfo(userId) async{
    final result = await _getService.getAllHomeInfo(userId);

    if(result != null){
      _homes = result;
    }
  }


  Future<HomeResponseModelMix?> getHomeAverageData() async{

    final homeAverageData = await _getService.getHomeAverageService();

    return homeAverageData;
  }


  Future<PlaceDetails?> getLocationInfo() async{
    final placeInfo =await _locationServices.getCurrentAddress();

    if(placeInfo == null) throw Exception("location not avilable");
    return placeInfo;
  }

}