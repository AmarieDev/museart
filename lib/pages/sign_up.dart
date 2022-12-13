import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/user.dart';
import 'package:flutter_application/pages/sign_in.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import '../reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../http_exception.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routName = "/sign-up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  bool _isConfPassObscure = true;
  final _form = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confPassController = TextEditingController();
  UserCredentials user = UserCredentials();
  String? _confPass;
  void _saveForm() {
    if (isFormValid()) {
      _form.currentState?.save();
    }
  }

  bool isFormValid() {
    final isValid = _form.currentState?.validate();
    if (isValid != null && isValid) {
      return true;
    } else {
      return false;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An Error Occurred!'),
              content: Text(message),
              actions: [
                ElevatedButton(
                  onPressed: (() {
                    _form.currentState!.deactivate();
                    _form.currentState!.activate();
                    Navigator.of(ctx).pop();
                  }),
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
                    myControler: _emailController,
                    inputType: TextInputType.emailAddress,
                    hintText: "Email",
                    save: (val) {
                      user.email = val!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MyTextField(
                  myControler: _passController,
                  hintText: "Password",
                  isObscure: _isObscure,
                  save: (val) {
                    user.password = val!;
                  },
                  mySuffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      size: 20.0,
                      color: Theme.of(context).primaryColorDark,
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
              MyPadding(
                child: SizedBox(
                  width: 235,
                  child: TextFormField(
                    controller: _confPassController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (val) {
                      _confPass = val;
                    },
                    obscureText: _isConfPassObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This input field can't be empty!";
                      } else if (value != _passController.text) {
                        return "Password must be same as above!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _isConfPassObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20.0,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _isConfPassObscure = !_isConfPassObscure;
                          });
                        },
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Confirm Password",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      hintStyle: const TextStyle(
                          fontSize: 15, color: Color(0xffB89C9C)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    _saveForm();
                    try {
                      if (_confPassController.text == _passController.text) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .signup(user.email, user.password)
                            .then((_) {
                          Navigator.pop(context);
                        });
                      }
                    } on HttpException catch (error) {
                      var errorMessage = 'Authentication Failed.';
                      if (error.toString().contains('EMAIL_EXISTS')) {
                        errorMessage = 'This emaill address is already in use';
                      } else if (error.toString().contains('INVALID_EMAIL')) {
                        errorMessage = 'This is not a valid email address';
                      } else if (error.toString().contains('WEAK_PASSWORD')) {
                        errorMessage = 'This password is too weak.';
                      }
                      _showErrorDialog(errorMessage);
                    } catch (error) {
                      var errorMessage = 'Authentiacation Failed!';
                      _showErrorDialog(errorMessage);
                    }
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
                    Navigator.pushNamed(context, "home");
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
