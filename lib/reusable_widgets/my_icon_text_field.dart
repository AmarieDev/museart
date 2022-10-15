import 'package:flutter/material.dart';

class CreateJamTextField extends StatelessWidget {
  const CreateJamTextField({
    required this.hintText,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        border: const UnderlineInputBorder(),
        labelText: hintText,
      ),
    );
  }
}
