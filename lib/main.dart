import 'package:flutter/material.dart';
import 'package:sleepy_head_panel/screens/home_screen.dart';
import 'package:sleepy_head_panel/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleepy Head ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
