import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class Appointment extends StatefulWidget {

  @override
  AppointmentState createState() => AppointmentState();
}

class AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: Padding(
      padding: EdgeInsets.all(1),
      child: Card(
        child: Form(
          key:  _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              )



            ],
          )),
      ),
      
      
      ),
    );
  }
}