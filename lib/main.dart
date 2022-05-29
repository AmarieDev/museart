import 'package:flutter/material.dart';
import 'sign_up.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        //brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),

        // Define the default font family.
        //fontFamily: 'Georgia',

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //primary: Colors.lightBlue[800],
            primary: const Color(0xff3E99FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
          button: TextStyle(fontSize: 15),
          headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const Scaffold(body: SignUp()),
    );
  }
}
