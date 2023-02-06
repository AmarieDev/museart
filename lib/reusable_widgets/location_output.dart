import 'package:flutter/material.dart';
import 'package:flutter_application/other/location_helper.dart';

class LocationOutput extends StatefulWidget {
  double? lat;
  double? lng;
  LocationOutput({@required this.lat, @required this.lng});

  @override
  State<LocationOutput> createState() => _LocationOutputState();
}

class _LocationOutputState extends State<LocationOutput> {
  String? _previewImageUrl;

  void _showPreview(double? lat, double? lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _generateOutput() async {
    _showPreview(widget.lat, widget.lng);
  }

  @override
  void initState() {
    _generateOutput();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      height: 170,
      width: double.infinity,
      alignment: Alignment.center,
      child: _previewImageUrl == null
          ? const Text(
              'No Location Chossen',
              textAlign: TextAlign.center,
            )
          : Image.network(
              _previewImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
    );
  }
}
