import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/PlaceLocation.dart';
import 'package:flutter_application/reusable_widgets/location_input.dart';
import 'package:flutter_application/reusable_widgets/location_output.dart';
import '../data_models/jam.dart';
import '../providers/jams_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class JamDetailPage extends StatefulWidget {
  // final String title;
  // JamDetailPage(this.title);
  static const routeName = "/jam-detail";

  @override
  State<JamDetailPage> createState() => _JamDetailPageState();
}

class _JamDetailPageState extends State<JamDetailPage> {
  late PlaceLocation _pickedLocation;

  void _selectedPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(lat: lat, lng: lng);
  }

  @override
  Widget build(BuildContext context) {
    final jamId = ModalRoute.of(context)?.settings.arguments;
    Jam loadedJam = Jam(
        id: "id",
        title: "title",
        date: "date",
        time: "time",
        location: null,
        maxJamers: 2);
    if (jamId != null) {
      loadedJam = Provider.of<JamsProvider>(context, listen: false)
          .findById(jamId.toString());
    }
    final String _genres = loadedJam.prefreableGenres.join(', ');
    final String _instuments = loadedJam.prefreableInstruments.join(', ');
    int joinedUsers = 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/david.jpg'),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ammar abi",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(" | Host")
                ],
              ),
              SizedBox(
                height: 35,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "go to Profile >",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Location'),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: LocationOutput(
                  lat: loadedJam.location!.lat,
                  lng: loadedJam.location!.lng,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Joined Users'),
                    Chip(
                      label: Text(
                          joinedUsers.toString() +
                              '/' +
                              loadedJam.maxJamers.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Text("genres: " + _genres),
                    Text("Looking for: " + _instuments),
                  ]),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      bottomSheet: Container(
        height: 125,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffD9D9D9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: Text(
                loadedJam.date + ' ' + loadedJam.time,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                loadedJam.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loadedJam.description),
                  ElevatedButton(
                    child: const Text(
                      'Join',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
