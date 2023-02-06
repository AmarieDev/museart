import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/create_jam.dart';
import 'package:flutter_application/pages/home_page.dart';
import 'package:flutter_application/pages/jams_detail_page.dart';
import 'package:flutter_application/pages/jams_page.dart';
import 'package:flutter_application/pages/user_data_form.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'pages/sign_in.dart';
import 'pages/sign_up.dart';
import './providers/jams_provider.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseStorage.instance.app;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UserProvider()),
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProxyProvider<AuthProvider, JamsProvider>(
            create: (_) => JamsProvider(null, null, []),
            update: (context, auth, previousJams) => (JamsProvider(
              auth.token,
              auth.getCurrentUserId(),
              previousJams == null ? [] : previousJams.jams,
            )),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xff3E99FF),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: const Color(0xffFF8383)),
              // Define the default font family.
              fontFamily: 'IBMPlexSans',

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
                headline6:
                    TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0),
              ),
            ),
            home: auth.isAuth
                ? HomePage()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        (authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Container(
                                color: Colors.red,
                              )
                            : const SignIn()),
                  ),
            routes: {
              'userForm': (context) => const UserDataForm(),
              'home': (context) => auth.isAuth ? HomePage() : const SignIn(),
              JamDetailPage.routeName: (context) => JamDetailPage(),
              JamsPage.routeName: (context) => const JamsPage(),
              CreateJamPage.routeName: (context) => const CreateJamPage(),
              SignIn.routeName: (context) => const SignIn(),
              SignUp.routeName: (context) => const SignUp(),
            },
          ),
        ));
  }
}
