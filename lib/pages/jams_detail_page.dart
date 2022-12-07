import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class JamDetailPage extends StatelessWidget {
  // final String title;
  // JamDetailPage(this.title);
  static const routName = "/jam-detail";

  @override
  Widget build(BuildContext context) {
    final jamId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
      title: Text("title"),
    ));
  }
}
