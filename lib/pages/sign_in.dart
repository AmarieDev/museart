import 'package:flutter/material.dart';
import 'package:flutter_application/pages/sign_up.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/reusable_widgets/logo.dart';
import '../reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../other/http_exception.dart';
import 'jams_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;
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
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text("Sign in",
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MyTextField(
                        inputType: TextInputType.emailAddress,
                        hintText: "Email",
                        save: (val) {
                          email = val!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MyTextField(
                        inputType: TextInputType.text,
                        hintText: "Password",
                        isObscure: _isObscure,
                        save: (val) {
                          password = val!;
                        },
                        mySuffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                            size: 20.0,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            SignUp.routeName,
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
                        Navigator.of(context).pushNamed(
                          'home',
                        );
                        /*
                        _saveForm();
                        try {
                          final authPovider =
                              Provider.of<AuthProvider>(context, listen: false);
                          await authPovider
                              .signin(email, password)
                              .whenComplete(() {
                            final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            userProvider.fetchUserData(
                                authPovider.getCurrentUserId(),
                                authPovider.token);
                          });
                        } on HttpException catch (error) {
                          var errorMessage = 'Authentication Failed!';
                          if (error.toString().contains('INVALID_EMAIL')) {
                            errorMessage = 'This is not a valid email address';
                          } else if (error
                              .toString()
                              .contains('EMAIL_NOT_FOUND')) {
                            errorMessage =
                                'Could not find a user with that email.';
                          } else if (error
                              .toString()
                              .contains('INVALID_PASSWORD')) {
                            errorMessage = 'Invalid password.';
                          }
                          _showErrorDialog(errorMessage);
                        } catch (error) {
                          var errorMessage = 'Authentication Failed!';
                          _showErrorDialog(errorMessage);
                        }
                        */
                      },
                      child: const Text("Sign in"),
                    ),
                  ],
                ),
              ),
              const Logo(),
            ],
          ),
        ),
      ),
    );
  }
}
