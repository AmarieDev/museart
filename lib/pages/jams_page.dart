import "package:flutter/material.dart";
import 'package:flutter_application/pages/jams_detail_page.dart';
import 'package:flutter_application/providers/jams_provider.dart';
import "package:provider/provider.dart";

class JamsPage extends StatefulWidget {
  const JamsPage({Key? key}) : super(key: key);
  static const routeName = "/jams-page";

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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: ListView.builder(
          itemCount: jams.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () async {
              final isJoined = await jamsData.hasAlreadyJoined(jams[i].id);
              Navigator.of(context).pushNamed(JamDetailPage.routeName,
                  arguments: {'id': jams[i].id, 'isJoined': isJoined});
            },
            child: ListTile(
              leading: const Icon(Icons.music_note),
              title: Text(jams[i].title),
              subtitle: Text(jams[i].description),
              trailing:
                  Text("Date: " + jams[i].date + " Time: " + jams[i].time),
            ),
          ),
        ),
      ),
    );
  }
}
