import 'package:flutter/material.dart';
import 'package:flutter_application/pages/sign_in.dart';
import '../reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  void _saveForm() {
    _form.currentState?.save();
  }

  late String email;
  late String password;

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
                child: Text("Sign up",
                    style: Theme.of(context).textTheme.headline1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                  hintText: "Username",
                  save: (val) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                    hintText: "Email",
                    save: (val) {
                      email = val!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                    hintText: "Password",
                    save: (val) {
                      password = val!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                  hintText: "Password",
                  save: (val) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _saveForm();
                    Provider.of<AuthProvider>(context, listen: false)
                        .signup(email, password);
                  },
                  child: const Text("Sign up"),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: const Text("  Back "),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
