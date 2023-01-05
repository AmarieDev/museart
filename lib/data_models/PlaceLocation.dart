import 'package:flutter/cupertino.dart';

class PlaceLocation {
  final double lat;
  final double long;
  final String? address;

  const PlaceLocation({
    required this.lat,
    required this.long,
    this.address,
  });
}
