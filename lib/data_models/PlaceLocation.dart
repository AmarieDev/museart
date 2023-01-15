import 'package:flutter/cupertino.dart';

class PlaceLocation {
  final double lat;
  final double lng;
  final String? address;

  const PlaceLocation({
    required this.lat,
    required this.lng,
    this.address,
  });
}
