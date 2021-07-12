import 'package:flutter/material.dart';
import 'package:sqliteapp/loginui/login.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomAppBarColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.white,
      ),
      home: Login(),
    );
  }
}
