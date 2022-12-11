import 'dart:html';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    required this.hintText,
    required this.save,
    this.isObscure = false,
    this.inputType,
    this.mySuffixIcon = null,
    this.readOnly = false,
    this.label,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final TextInputType? inputType;
  final Function(String? val) save;
  IconButton? mySuffixIcon;
  String? label;
  bool isObscure;
  bool readOnly;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 235,
      height: 39,
      child: TextFormField(
        keyboardType: inputType,
        onSaved: save,
        readOnly: readOnly,
        obscureText: isObscure,
        decoration: InputDecoration(
          suffixIcon: mySuffixIcon,
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
