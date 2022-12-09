import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_page.dart';
import 'package:flutter_application/pages/sign_up.dart';
import '../reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../http_exception.dart';

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

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An Error Occurred!'),
              content: Text(message),
              actions: [
                ElevatedButton(
                  onPressed: (() => Navigator.of(ctx).pop()),
                  child: const Text('Okay'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ));
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
                onPressed: () async {
                  _saveForm();
                  try {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signin(email, password);
                  } on HttpException catch (error) {
                    var errorMessage = 'Authentiacation Failed.';
                    if (error.toString().contains('INVALID_EMAIL')) {
                      errorMessage = 'This is not a valid email address';
                    } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
                      errorMessage = 'Could not find a user with that email.';
                    } else if (error.toString().contains('INVALID_PASSWORD')) {
                      errorMessage = 'Invalid password.';
                    }
                    _showErrorDialog(errorMessage);
                  } catch (error) {
                    var errorMessage =
                        'Authentiacation Failed. Please check your internet conection and try again later!';
                    _showErrorDialog(errorMessage);
                  }
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
