import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.hintText,
    this.readOnly = false,
    this.label,
    Key? key,
  }) : super(key: key);
  final String hintText;
  String? label;
  bool readOnly;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 235,
      height: 39,
      child: TextField(
        readOnly: readOnly,
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
