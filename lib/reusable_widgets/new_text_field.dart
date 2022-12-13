import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  NewTextField({
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
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 19),
          hintStyle: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: "IBMPlexSansBold"),
        ),
      ),
    );
  }
}
