import 'package:flutter/cupertino.dart';
import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:flutterlearn/data/repository/HomeRepository/homeRepository.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepository _repository;
  HomeProvider(this._repository);

  HomeModel get homePostData => _repository.homePostData;

  List<HomeModel> get homesList => _repository.homes;

  //variables

  bool _isloading = false;

  bool get isLoading => _isloading;


  Future<void> createHome(homeName, userId, homeLongitude, homeLatitude) async {
    _isloading = true;
    notifyListeners();
    await _repository.createHome(homeName, userId, homeLongitude, homeLatitude);
    await _repository.getHomeInfo(userId);
    _isloading = false;
    notifyListeners();
  }


  Future<void> getHomeInfo(userId)async{
    _isloading = true;
    notifyListeners();
    await _repository.getHomeInfo(userId);
    _isloading = false;
    notifyListeners();
  }

}
