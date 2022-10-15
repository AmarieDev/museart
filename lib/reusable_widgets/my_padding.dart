import 'package:flutter/material.dart';

class MyPadding extends StatelessWidget {
  const MyPadding({
    Key? key,
    required this.child,
    this.vertical = 8,
    this.horizental = 32,
  }) : super(key: key);
  final Widget child;
  final double vertical;
  final double horizental;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizental, vertical: vertical),
      child: child,
    );
  }
}
