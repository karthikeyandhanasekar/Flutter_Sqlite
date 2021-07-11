import 'package:flutter/material.dart';
import 'package:sqliteapp/appointmentform.dart';
import 'package:sqliteapp/loginui/login.dart';
import 'package:sqliteapp/show.dart';

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
        primarySwatch: Colors.teal,
      ),
      home: Login(),
    );
  }
}
