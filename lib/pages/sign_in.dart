import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_page.dart';
import 'package:flutter_application/pages/sign_up.dart';
import '../reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _form = GlobalKey<FormState>();
  late String email;
  late String password;
  void _saveForm() {
    _form.currentState?.save();
  }

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
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text("Sign in",
                    style: Theme.of(context).textTheme.headline1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                  hintText: "Username",
                  save: (val) {
                    email = val!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                  hintText: "Password",
                  save: (val) {
                    password = val!;
                  },
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
                onPressed: () {
                  _saveForm();
                  Provider.of<AuthProvider>(context, listen: false)
                      .signin(email, password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JamsPage()),
                  );
                },
                child: const Text("Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
