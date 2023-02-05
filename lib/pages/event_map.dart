import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/jam_location.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:provider/provider.dart";
import 'package:flutter_application/providers/jams_provider.dart';
import 'jams_detail_page.dart';

class EventMapPage extends StatefulWidget {
  final LocationData? _currentPos;
  // ignore: use_key_in_widget_constructors
  const EventMapPage(this._currentPos);
  @override
  _EventMapPageState createState() => _EventMapPageState();
}

class _EventMapPageState extends State<EventMapPage> {
  double? initLat;
  double? initLong;
  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  Future<JamLocation> getInitPos() async {
    initLat = widget._currentPos!.latitude!;
    initLong = widget._currentPos!.longitude!;

    return JamLocation(lat: initLat!, lng: initLong!);
  }

  Location location = Location();

  final Set<Marker> _markers = {};
  GoogleMapController? _controller;
  bool _showButton = false;
  String? selectedJamId;

  void _addMapStyle() async {
    String mapStyle =
        await DefaultAssetBundle.of(context).loadString('assets/mapStyle.json');
    _controller?.setMapStyle(mapStyle);
  }

  void _getEvents() async {
    final jamsData = Provider.of<JamsProvider>(context, listen: false);
    final jams = jamsData.jams;
    setState(() {
      _markers.clear();
      for (var element in jams) {
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
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _addMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    final jamsData = Provider.of<JamsProvider>(context, listen: false);
    return FutureBuilder(
        future: getInitPos(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(initLat!, initLong!),
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
                          Navigator.of(context)
                              .pushNamed(JamDetailPage.routeName, arguments: {
                            'id': selectedJamId!,
                            'isJoined': isJoined
                          });
                        },
                        child: const Text("View Jam"),
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
        });
  }
}
