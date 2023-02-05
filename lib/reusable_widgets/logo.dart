import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Image(
        image: AssetImage('assets/images/Museart.png'),
        width: 88,
        height: 14,
      ),
      Image(
        image: AssetImage('assets/images/MusikNote.png'),
        width: 50,
        height: 70,
      ),
    ]);
  }
}
