import 'package:flutter/material.dart';
import 'package:flutter_application/sign_up.dart';
import 'my_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff81BDFF),
              Color(0xffFF8383),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child:
                  Text("Sign in", style: Theme.of(context).textTheme.headline1),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MyTextField(
                hintText: "Username",
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MyTextField(
                hintText: "Password",
              ),
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                child: const Text(
                  "Don’t have an account yet? Sign Up",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
