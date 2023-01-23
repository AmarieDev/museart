import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/PlaceLocation.dart';
import '../reusable_widgets/map.dart';
import 'package:flutter_application/reusable_widgets/location_output.dart';
import '../data_models/jam.dart';
import '../providers/jams_provider.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class JamDetailPage extends StatefulWidget {
  static const routeName = "/jam-detail";
  late bool isJoined;

  @override
  State<JamDetailPage> createState() => _JamDetailPageState();
}

class _JamDetailPageState extends State<JamDetailPage> {
  @override
  Widget build(BuildContext context) {
    final jamsProv = Provider.of<JamsProvider>(context, listen: true);
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String jamId = arguments['id'];
    widget.isJoined = arguments['isJoined'];

    Jam loadedJam = Jam(
      id: "id",
      title: "title",
      date: "date",
      time: "time",
      location: PlaceLocation(lat: 0, lng: 0),
      maxJamers: 2,
    );
    loadedJam = jamsProv.findById(jamId.toString());
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
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 3.0),
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
              GestureDetector(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: LocationOutput(
                    lat: loadedJam.location.lat,
                    lng: loadedJam.location.lng,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapPage(
                      isSelecting: false,
                      initialLocation: PlaceLocation(
                        lat: loadedJam.location.lat,
                        lng: loadedJam.location.lng,
                      ),
                    ),
                  ));
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Joined Users'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Chip(
                        padding: EdgeInsets.all(0),
                        label: Text(
                            (loadedJam.joinedUsers.length - 1).toString() +
                                '/' +
                                loadedJam.maxJamers.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
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
                    Text("Genre: " + _genres),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                    onPressed: () {
                      setState(() {
                        jamsProv.joinUnjoinJam(loadedJam.id);
                      });

                      Navigator.pop(context);
                    },
                    child: Text(
                      widget.isJoined ? 'unjoin' : 'join',
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
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
