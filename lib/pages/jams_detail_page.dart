import 'package:flutter/material.dart';
import '../data_models/jam.dart';
import '../providers/jams_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class JamDetailPage extends StatelessWidget {
  // final String title;
  // JamDetailPage(this.title);
  static const routeName = "/jam-detail";

  @override
  Widget build(BuildContext context) {
    final jamId = ModalRoute.of(context)?.settings.arguments;
    Jam loadedJam = Jam(
        id: "id",
        title: "title",
        date: "date",
        time: "time",
        location: "location",
        maxJamers: 2);
    if (jamId != null) {
      loadedJam = Provider.of<JamsProvider>(context, listen: false)
          .findById(jamId.toString());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/david.jpg'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'folding person',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(" | Host")
                ],
              ),
              SizedBox(
                height: 20,
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
                  children: [
                    Text('Location'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Joined Users'),
                    Chip(
                      label: Text('7/10',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Container(
                height: 60,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    const Text('Genre: Rock, Metal'),
                    const Text('Looking for: Dine Mama'),
                  ]),
              SizedBox(
                height: 100,
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
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontSize: 20.0),
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
