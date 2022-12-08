import 'package:flutter/material.dart';
import '../providers/jams_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class JamDetailPage extends StatelessWidget {
  // final String title;
  // JamDetailPage(this.title);
  static const routName = "/jam-detail";

  @override
  Widget build(BuildContext context) {
    final jamId = ModalRoute.of(context)?.settings.arguments as int;
    final loadedJam =
        Provider.of<JamsProvider>(context, listen: false).findById(jamId);
    return Scaffold(
        appBar: AppBar(
      title: Text(loadedJam.title),
    ));
  }
}
