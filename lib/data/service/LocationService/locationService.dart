import 'dart:developer';

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

import '../../model/LocationModel/locationModel.dart';


class LocationServices {

  final loc.Location _location = loc.Location();


  /// Gets current location and returns a PlaceDetails object
  Future<PlaceDetails?> getCurrentAddress() async {
    try {
      log ("Step 1: Check if location services are enabled");
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          print('❌ Location services are disabled.');
          return null;
        }
      }


      // Step 2: Check/request permission
      loc.PermissionStatus permission = await _location.hasPermission();

      if (permission == loc.PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != loc.PermissionStatus.granted) {
          print('❌ Location permission denied.');
          return null;
        }
      }


      // Step 3: Get current location
      final locationData = await _location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;

      print("the latitude is : $latitude");



      if (latitude == null || longitude == null) {
        print('⚠️ Invalid location data.');
        return null;
      }

      // Step 4: Reverse geocode to get address
      final placeMarks = await geo.placemarkFromCoordinates(latitude, longitude);
      if (placeMarks.isEmpty) {
        print('❌ No place data found.');
        return null;
      }

      final place = placeMarks.first;

      // Step 5: Return PlaceDetails object
      return PlaceDetails(
        latitude: latitude,
        longitude: longitude,
        name: place.country,
        street: place.street,
        subLocality: place.subLocality,
        locality: place.locality,
        administrativeArea: place.administrativeArea,
        country: place.country,
        postalCode: place.postalCode,
      );

    } catch (e) {
      print('🚨 Error getting location: $e');
      return null;
    }
  }
}
