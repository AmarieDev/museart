import 'package:flutter/material.dart';
import '../providers/jams_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class JamDetailPage extends StatelessWidget {
  // final String title;
  // JamDetailPage(this.title);
  static const routeName = "/jam-detail";

  @override
  Widget build(BuildContext context) {
    final jamId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedJam =
        Provider.of<JamsProvider>(context, listen: false).findById(jamId);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
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
            Text('folding person | Host'),
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "go to Profile >",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Location'),
                Text(
                  '1,6 km',
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Joined Users'),
                Text(
                  '7/10',
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: MediaQuery.of(context).size.width),
              const Text('Genre: Rock, Metal'),
              const Text('Looking for: Dine Mama'),
            ])
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffD9D9D9),
        child: Column(
          children: [
            Text(loadedJam.date + ' ' + loadedJam.time),
            Text(loadedJam.title),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
