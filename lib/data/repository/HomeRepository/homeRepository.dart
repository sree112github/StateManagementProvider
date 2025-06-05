

import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:flutterlearn/data/service/HomeServices/Get/GetHomeService.dart';
import 'package:flutterlearn/data/service/HomeServices/Post/CreateHomePostService.dart';

class HomeRepository{

  HomePostService _postService;
  HomeGetService _getService;

  List<HomeModel> _homes = [];

  List<HomeModel> get homes => _homes;

  HomeRepository(this._postService,this._getService);

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

}