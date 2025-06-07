
class PlaceDetails {
  final double? latitude;
  final double? longitude;

  final String? name;
  final String? street;
  final String? subLocality;
  final String? locality;
  final String? administrativeArea;
  final String? country;
  final String? postalCode;

  PlaceDetails({
    this.latitude,
    this.longitude,
    this.name,
    this.street,
    this.subLocality,
    this.locality,
    this.administrativeArea,
    this.country,
    this.postalCode,
  });

  /// Convert to a map (if needed for storage or serialization)
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'street': street,
      'subLocality': subLocality,
      'locality': locality,
      'administrativeArea': administrativeArea,
      'country': country,
      'postalCode': postalCode,
    };
  }


}
