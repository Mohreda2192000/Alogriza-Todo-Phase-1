import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: double.infinity,
      height: 1,
    );
  }
}
