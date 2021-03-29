import 'package:flutter/material.dart';

class AndroidProgressModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      )),
    );
  }
}
