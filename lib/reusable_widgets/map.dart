import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/jam_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final JamLocation initialLocation;
  final bool isSelecting;
  // ignore: use_key_in_widget_constructors
  const MapPage({
    this.initialLocation = const JamLocation(lat: 37.465465, lng: -122.135),
    this.isSelecting = false,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.initialLocation.lat, widget.initialLocation.lng),
            zoom: 16),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: {
          Marker(
            visible:
                widget.isSelecting && _pickedLocation == null ? false : true,
            markerId: const MarkerId('m2'),
            position: _pickedLocation ??
                LatLng(widget.initialLocation.lat, widget.initialLocation.lng),
          )
        },
      ),
    );
  }
}
