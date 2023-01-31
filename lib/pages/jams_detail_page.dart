import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/PlaceLocation.dart';
import '../data_models/user.dart';
import '../reusable_widgets/map.dart';
import 'package:flutter_application/reusable_widgets/location_output.dart';
import '../data_models/jam.dart';
import '../providers/jams_provider.dart';
import '../providers/user_provider.dart';
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
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    userProv.fetchUserData(authProv.getCurrentUserId(), authProv.token);

    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String jamId = arguments['id'];
    widget.isJoined = arguments['isJoined'];

    Jam loadedJam = Jam(
      id: "id",
      title: "title",
      date: "date",
      time: "time",
      host: "",
      location: PlaceLocation(lat: 0, lng: 0),
      maxJamers: 2,
    );
    loadedJam = jamsProv.findById(jamId.toString());
    final String _genres = loadedJam.prefreableGenres.join(', ');
    final String _instuments = loadedJam.prefreableInstruments.join(', ');
    List<User> joinedUsers = [];
    Future<dynamic>? _future;
    Future<void> fetchJoindUsers() async {
      if (loadedJam.joinedUsers != null) {
        for (var element in loadedJam.joinedUsers!) {
          if (element != "" || element != null || element != Null) {
            await userProv.getUser(element, authProv.token).then((value) {
              if (value != null) {
                joinedUsers.add(value);
              }
            });
          }
        }
      }
    }

    _future = fetchJoindUsers();

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(userProv.user != null
                                    ? userProv.user!.profileImageUrl.toString()
                                    : "https://cdn.pixabay.com/photo/2017/11/15/09/28/music-player-2951399_960_720.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userProv.user?.name ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                                  padding: const EdgeInsets.all(0),
                                  label: Text(
                                      loadedJam.joinedUsers?.length != null
                                          ? (loadedJam.joinedUsers!.length - 1)
                                                  .toString() +
                                              '/' +
                                              loadedJam.maxJamers.toString()
                                          : '0/' +
                                              loadedJam.maxJamers.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
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
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: const BoxDecoration(
                              color: Color(0xffD9D9D9),
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: joinedUsers.length,
                                itemBuilder: (ctx, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 90),
                                    child: SizedBox(
                                      height: 25,
                                      child: ListTile(
                                          leading: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Text(
                                              joinedUsers.isNotEmpty
                                                  ? joinedUsers[i]
                                                      .name
                                                      .toString()
                                                  : "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          trailing: SizedBox(
                                            width: 60,
                                            child: Text(joinedUsers.isNotEmpty
                                                ? joinedUsers[i]
                                                    .proficiency
                                                    .toString()
                                                : ""),
                                          )),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width),
                              Text("Genre: " + _genres),
                              Text("Looking for: " + _instuments),
                            ]),
                        const SizedBox(
                          height: 130,
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            }),
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
