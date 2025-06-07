

class HomeResponseModelMix{
  final HomeAverage? homeAverage;
  final  List<RoomAverage>? roomAverage;

  HomeResponseModelMix({required this.homeAverage, required this.roomAverage});


factory HomeResponseModelMix.fromJson(Map<String, dynamic> json){

  return HomeResponseModelMix(
      homeAverage: HomeAverage.fromJson(json['homeAverage']),
      roomAverage: List<RoomAverage>.from(json['roomAverages'].map((x) => RoomAverage.fromJson(x)))
  );
}




}



class HomeAverage{
  final String? homeId;
  final String? homeName;
  final double? aqi;
  final double? temperature;
  final double? humidity;
  final double? co2;
  final double? pressure;
  final double? voc;

  HomeAverage(    {
    required this.homeId,
    required this.homeName,
    required this.aqi,
    required this.temperature,
    required this.humidity,
    required this.co2,
    required this.pressure,
    required this.voc});


  factory HomeAverage.fromJson(Map<String, dynamic> json){

     return HomeAverage(
         homeId: json['home_id'],
         homeName: json['home_name'],
         aqi: json['AQI'],
         temperature: json['temperature'],
         humidity: json['humidity'],
         co2: json['co2'],
         pressure: json['pressure'],
         voc: json['voc']
     );
  }
}




class RoomAverage{
final String? roomId;
final String? roomName;
final double? aqi;
final double? temperature;
final double? humidity;
final double? co2;
final double? pressure;
final double? voc;

RoomAverage(
    {
      required this.roomId,
      required this.roomName,
      required this.aqi,
      required this.temperature,
      required this.humidity,
      required this.co2,
      required this.pressure,
      required this.voc}
    );

factory RoomAverage.fromJson(Map<String, dynamic> json){

  return RoomAverage(
    roomId: json['room_id'],
    roomName: json['roomName'],
    aqi: json['AQI'],
    temperature: json['temperature'],
    humidity: json['humidity'],
    co2: json['co2'],
    pressure: json['pressure'],
    voc: json['voc']
  );
}

}