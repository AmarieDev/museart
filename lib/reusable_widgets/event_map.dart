import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:provider/provider.dart";
import 'package:flutter_application/providers/jams_provider.dart';
import '../pages/jams_detail_page.dart';

class EventMapPage extends StatefulWidget {
  final LocationData _currentPos;
  const EventMapPage(this._currentPos);
  @override
  _EventMapPageState createState() => _EventMapPageState();
}

class _EventMapPageState extends State<EventMapPage> {
  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  Location location = Location();

  Set<Marker> _markers = {};
  GoogleMapController? _controller;
  bool _showButton = false;
  String? selectedJamId;
  void _getEvents() async {
    final jamsData = Provider.of<JamsProvider>(context, listen: false);
    final jams = jamsData.jams;
    setState(() {
      _markers.clear();
      jams.forEach((element) {
        var lat = element.location.lat;
        var lng = element.location.lng;
        var title = element.title;
        var jamId = element.id;
        var marker = Marker(
          markerId: MarkerId(jamId),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: title,
          ),
          onTap: () {
            setState(
              () {
                _showButton = true;
                selectedJamId = jamId;
              },
            );
          },
        );
        _markers.add(marker);
      });
    });
  }

  @override
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final jamsData = Provider.of<JamsProvider>(context, listen: false);
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget._currentPos.latitude as double,
                widget._currentPos.longitude as double),
            zoom: 14.0,
          ),
          markers: _markers,
        ),
        _showButton
            ? Positioned(
                bottom: 50,
                right: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    final isJoined =
                        await jamsData.hasAlreadyJoined(selectedJamId!);
                    Navigator.of(context).pushNamed(JamDetailPage.routeName,
                        arguments: {
                          'id': selectedJamId!,
                          'isJoined': isJoined
                        });
                  },
                  child: Text("View Event"),
                ),
              )
            : Container(),
      ]),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
      */
    );
  }
}