import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore API Demo',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
