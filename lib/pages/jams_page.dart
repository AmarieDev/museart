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
    // Future.delayed(Duration.zero).then((value) =>
    //    Provider.of<JamsProvider>(context, listen: false).fetchJams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jamsData = Provider.of<JamsProvider>(context);
    Future<void> _refreshData() async {
      // Fetch new data and update the state
      setState(() {
        Future.delayed(Duration.zero).then((value) =>
            Provider.of<JamsProvider>(context, listen: false).fetchJams());
      });
    }

    final jams = jamsData.jams;
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
                Navigator.of(context).pushNamed(JamDetailPage.routeName,
                    arguments: {'id': jams[i].id, 'isJoined': isJoined});
              },
              child: ListTile(
                leading: const Icon(Icons.music_note),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        jams[i].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      jams[i].date,
                      style: const TextStyle(fontSize: 14),
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
                        (jams[i].joinedUsers.length - 1).toString() +
                            '/' +
                            jams[i].maxJamers.toString(),
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
    );
  }
}
