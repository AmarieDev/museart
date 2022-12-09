import "package:flutter/material.dart";
import 'package:flutter_application/pages/jams_detail_page.dart';
import 'package:flutter_application/providers/jams_provider.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import "package:provider/provider.dart";

import 'create_jam.dart';

class JamsPage extends StatefulWidget {
  const JamsPage({Key? key}) : super(key: key);

  @override
  State<JamsPage> createState() => _JamsPageState();
}

class _JamsPageState extends State<JamsPage> {
  @override
  void initState() {
    Provider.of<JamsProvider>(context, listen: false).fetchJams();
    // work around if listen is set to true
    //  Future.delayed(Duration.zero).then((value) =>
    //      Provider.of<JamsProvider>(context, listen: false).fetchJams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jamsData = Provider.of<JamsProvider>(context);
    final jams = jamsData.jams;
    return Scaffold(
      body: MyPadding(
        child: ListView.builder(
          itemCount: jams.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                JamDetailPage.routName,
                arguments: jams[i].id,
              );
            },
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.music_note),
                onPressed: () {},
              ),
              title: Text(jams[i].title),
              subtitle: Text(jams[i].description),
              trailing:
                  Text("Date: " + jams[i].date + " Time: " + jams[i].time),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        color: const Color(0xffC0A0C1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateJamPage()),
                );
              },
              child: const Text("Home"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateJamPage(),
                  ),
                );
              },
              child: const Text("Create Jam"),
            ),
          ],
        ),
      ),
    );
  }
}
