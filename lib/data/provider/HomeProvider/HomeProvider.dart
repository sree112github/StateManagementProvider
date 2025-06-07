import 'package:flutter/cupertino.dart';
import 'package:flutterlearn/data/model/HomeModel/homeModel.dart';
import 'package:flutterlearn/data/model/LocationModel/locationModel.dart';
import 'package:flutterlearn/data/model/MixedModels/HomeResponseModel.dart';
import 'package:flutterlearn/data/repository/HomeRepository/homeRepository.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepository _repository;
  HomeProvider(this._repository);

  HomeModel get homePostData => _repository.homePostData;

  List<HomeModel> get homesList => _repository.homes;

  HomeResponseModelMix? get homeAverageData => _homeAverageData;


  //variables

  bool _isLoading = false;
  PlaceDetails? _currentLocationDetails;
  HomeResponseModelMix? _homeAverageData;

  bool get isLoading => _isLoading;
  PlaceDetails? get currentLocationDetails => _currentLocationDetails;


  Future<void> createHome(homeName, userId, homeLongitude, homeLatitude) async {
    _isLoading = true;
    notifyListeners();
    await _repository.createHome(homeName, userId, homeLongitude, homeLatitude);
    await _repository.getHomeInfo(userId);
    _isLoading = false;
    notifyListeners();
  }


  Future<void> getHomeInfo(userId)async{
    _isLoading = true;
    notifyListeners();
    await _repository.getHomeInfo(userId);
    _isLoading = false;
    notifyListeners();
  }


  Future<HomeResponseModelMix?> getHomeAverageData() async{
    _isLoading = true;
    notifyListeners();
   final homeAverageData= await _repository.getHomeAverageData();
   if(homeAverageData == null){
     return null;
   }
   _homeAverageData = homeAverageData;
   _isLoading = false;
   notifyListeners();

  }

  /// Fetch current location and notify listeners
  Future<void> fetchCurrentPlace() async {
    _isLoading = true;
    notifyListeners();

    try {
      final place = await _repository.getLocationInfo();
      if (place == null) {
        print("no data found");
      }
      _currentLocationDetails = place;
    } catch (e) {
     print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  }


