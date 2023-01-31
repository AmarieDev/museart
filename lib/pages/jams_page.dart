import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_application/pages/jams_detail_page.dart';
import 'package:flutter_application/providers/auth_provider.dart';
import 'package:flutter_application/providers/jams_provider.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/reusable_widgets/event_map.dart';
import "package:provider/provider.dart";
import 'package:location/location.dart';

class JamsPage extends StatefulWidget {
  const JamsPage({Key? key}) : super(key: key);
  static const routeName = "/jams-page";

  @override
  State<JamsPage> createState() => _JamsPageState();
}

class _JamsPageState extends State<JamsPage> {
  Location location = Location();
  Future<LocationData>? _future;
  @override
  void initState() {
    Provider.of<JamsProvider>(context, listen: false).fetchJams();
    _future = location.getLocation();
    // work around if listen is set to true
    // Future.delayed(Duration.zero).then((value) =>
    //    Provider.of<JamsProvider>(context, listen: false).fetchJams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jamsData = Provider.of<JamsProvider>(context);
    final userProv = Provider.of<UserProvider>(context);
    Future<void> _refreshData() async {
      // Fetch new data and update the state
      setState(() {
        Future.delayed(Duration.zero).then((value) =>
            Provider.of<JamsProvider>(context, listen: false).fetchJams());
      });
    }

    final jams = jamsData.jams;
    LocationData _currentLocation;
    Future<LocationData> getCurrentLocation() async {
      _currentLocation = await location.getLocation();
      return _currentLocation;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.builder(
            itemCount: jams.length,
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () async {
                final isJoined = await jamsData.hasAlreadyJoined(jams[i].id);
                Navigator.of(context)
                    .pushNamed(JamDetailPage.routeName, arguments: {
                  'id': jams[i].id,
                  'isJoined': isJoined,
                });
              },
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 50,
                  height: 50,
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          jams[i].title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      jams[i].date,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(jams[i].description),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Chip(
                    padding: const EdgeInsets.all(0),
                    label: Text(
                        jams[i].joinedUsers?.length != null
                            ? (jams[i].joinedUsers!.length - 1).toString() +
                                '/' +
                                jams[i].maxJamers.toString()
                            : '0/' + jams[i].maxJamers.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10)),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(
            Icons.public,
            size: 48.0,
            color: Colors.black,
          ),
          onPressed: () {
            getCurrentLocation();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FutureBuilder(
                        future: _future,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return EventMapPage(snapshot.data);
                            }
                          } else {
                            return const Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                          }
                        })));
          },
        ),
      ),
    );
  }
}
