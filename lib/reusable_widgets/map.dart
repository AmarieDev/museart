import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/PlaceLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const Map({
    this.initialLocation = const PlaceLocation(lat: 37.465465, long: -122.135),
    this.isSelecting = false,
  });

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.initialLocation.lat, widget.initialLocation.long),
            zoom: 16),
      ),
    );
  }
}
