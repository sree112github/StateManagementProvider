

//Top level

class HomeResponseModel {
  final String message;
  final List<HomeModel> data;

  HomeResponseModel({required this.message, required this.data});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      message: json['message'],
      data: List<HomeModel>.from(
        json['data'].map((item) => HomeModel.fromJson(item)),
      ),
    );
  }
}


class HomeModel{
  String? homeId;
  String? homeName;
  double? homeLongitude;
  double? homeLatitude;
  String? homePlace;
  DateTime? homeCreatedAt;
  String? userId;
  int? statusCode;

  HomeModel(
      this.homeId,
      this.homeName,
      this.homeLongitude,
      this.homeLatitude,
      this.homePlace,
      this.homeCreatedAt, {
        this.userId,
        this.statusCode,
      });

  Map<String, dynamic> toJson() {
    return {
      "name": homeName,
      "userId": userId,
      "location": {
        "type": "point",
        "coordinates": [homeLongitude, homeLatitude]
      }
    };
  }

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      json['home_id'],
      json['name'],
      json['location']['longitude']?.toDouble(),
      json['location']['latitude']?.toDouble(),
      null, // homePlace not in response
      null, // homeCreatedAt not in response
    );
  }
}




