import 'package:flutter/material.dart';

class Location{
  final double latitude;
  final double longitude;
  final String address;


  const Location({
    @required this.latitude,
    @required this.longitude,
    @required this.address,
  });

  Map<String, dynamic> toJson(Location placeLocation) => {
    'Latitude': placeLocation.latitude != null ? placeLocation.latitude : 1,
    'Longitude': placeLocation.longitude != null ? placeLocation.longitude : 1,
    'Address': placeLocation.address != null ? placeLocation.address : 'unknown',
  };
}