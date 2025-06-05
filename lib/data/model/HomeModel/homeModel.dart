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
class HomeModel {
  String? homeId;
  String? homeName;
  double? homeLongitude;
  double? homeLatitude;
  String? homePlace;
  DateTime? homeCreatedAt;
  String? userId;
  int? statusCode;

  HomeModel({
    this.homeId,
    this.homeName,
    this.homeLongitude = 0.0,
    this.homeLatitude = 0.0,
    this.homePlace,
    this.homeCreatedAt,
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
    final location = json['location'] is Map<String, dynamic> ? json['location'] : {};

    return HomeModel(
      homeId: json['home_id'],
      homeName: json['name'] ?? 'Unnamed Home',
      homeLongitude: location['longitude']?.toDouble() ?? 2.3,
      homeLatitude: location['latitude']?.toDouble() ?? 0.0,
      homePlace: json['place'] ?? 'Unknown Place',
      homeCreatedAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      userId: json['userId'],
      statusCode: json['statusCode'],
    );
  }
}
