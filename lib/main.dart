import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_detail_page.dart';
import 'pages/sign_in.dart';
import './providers/jams_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JamsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          //brightness: Brightness.dark,
          primaryColor: const Color(0xff3E99FF),

          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xffFF8383)),

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
            headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0),
          ),
        ),
        home: const SignIn(),
        routes: {
          JamDetailPage.routName: (context) => JamDetailPage(),
        },
      ),
    );
  }
}
