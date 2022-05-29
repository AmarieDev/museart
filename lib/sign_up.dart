import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffFF8383),
              Color(0xff81BDFF),
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
                  Text("Sign up", style: Theme.of(context).textTheme.headline1),
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
                hintText: "Email",
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MyTextField(
                hintText: "Password",
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MyTextField(
                hintText: "Password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Sign up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    required this.hintText,
    Key? key,
  }) : super(key: key);
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 235,
      height: 39,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 19),
          hintStyle: const TextStyle(fontSize: 15, color: Color(0xffB89C9C)),
        ),
      ),
    );
  }
}
