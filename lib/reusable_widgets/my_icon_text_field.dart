import 'package:flutter/material.dart';

class CreateJamTextField extends StatelessWidget {
  const CreateJamTextField({
    required this.hintText,
    required this.icon,
    required this.keybType,
    required this.save,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final Icon icon;
  final TextInputType keybType;
  final Function(String? val) save;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: keybType,
      onSaved: save,
      decoration: InputDecoration(
        icon: icon,
        border: const UnderlineInputBorder(),
        labelText: hintText,
      ),
    );
  }
}
