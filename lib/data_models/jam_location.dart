import 'package:flutter/cupertino.dart';

class JamLocation {
  final double lat;
  final double lng;
  final String? address;

  const JamLocation({
    required this.lat,
    required this.lng,
    this.address,
  });
}
