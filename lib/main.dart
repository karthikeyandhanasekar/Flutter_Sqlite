import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/loginui/doctorlogin.dart';
import 'package:sqliteapp/loginui/login.dart';
import 'package:sqliteapp/sqlite3/database.dart';
import 'package:sqliteapp/userdetails.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Data>(
      create: (_) => database(),
      lazy: false,
  
      child: MaterialApp(
        title: 'Appointment Booking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomAppBarColor: Colors.deepOrangeAccent,
          backgroundColor: Colors.white,
        ),
        home: Login(),
      ),
    );
  }
}
