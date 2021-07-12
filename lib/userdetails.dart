import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';
import 'package:sqliteapp/sqlite3/database.dart';

final  _formKey = GlobalKey<FormState>();

TextEditingController _fullname = new TextEditingController();
TextEditingController _phone = new TextEditingController();
TextEditingController _street = new TextEditingController();
TextEditingController _city = new TextEditingController();
TextEditingController _zipcode = new TextEditingController();
TextEditingController _email = new TextEditingController();
TextEditingController _doctorname = new TextEditingController();
var currentyear = new DateTime.now().year;
String? _appointtime;
class UserDetails extends StatefulWidget
{
  final String email;

   UserDetails({ required this.email}); 

  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  @override
  void dispose() {
    _fullname.clear();
    _phone.clear();
    _street.clear();
    _city.clear();
    _zipcode.clear();
    _email.clear();
    _doctorname.clear();
    super.dispose();
  }
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
         title: Text('Appointment',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),),
titleTextStyle: TextStyle(
  color: Colors.black,
) ,
        elevation: 20.0,
      ),
      body:
      AuthPage(context)
    );
  }

  Widget AuthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
    
          Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child:SizedBox(
              height: double.maxFinite,
              child: new Form(
                key: _formKey,
                  child:ListView(
                    children: <Widget>[
                     CustomTextField.TextFieldType(context,_fullname,Icon(Icons.text_fields_outlined),TextInputType.text,"Full Name"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.TextFieldType(context,_phone,Icon(Icons.phone_callback),TextInputType.phone,"Number",),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField.TextFieldType(context,_street,Icon(Icons.streetview_outlined),TextInputType.text,"Street Address",),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded
                          (child: CustomTextField.TextFieldType(context,_city,Icon(Icons.location_city_outlined),TextInputType.text,"City",)),
                      SizedBox(
                        height: 10,
                      ),
                        Expanded
                          (child: CustomTextField.TextFieldType(context,_zipcode,Icon(Icons.code_outlined),TextInputType.number,"ZipCode",)),
                      SizedBox(
                        height: 10,
                      ),
                       ],),
                      CustomTextField.TextFieldType(context,_doctorname,Icon(Icons.people_alt_outlined),TextInputType.text,"Doctor Name"),
                      SizedBox(
                        height: 10,
                      ),

                       DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd-MMM-yyyy',
                    firstDate: DateTime(currentyear),
                    lastDate: DateTime(currentyear+10),
                    dateLabelText : 'Date',
                    timeLabelText: 'Time',
                    
                    icon: Icon(Icons.date_range),
                    onSaved: (value)
                    {
                        _appointtime = value;
                    },
                    onChanged: (value)
                    {
                      _appointtime = value;
                      print(_appointtime);

                    },
                  ),
                    
                  SubmitButton(context)
                      
                    ],
                  )
              ),
            )
    
          ),
        ],
      ),
    );
  }


Widget SubmitButton(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: ElevatedButton.icon(
                    
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          elevation: 3,
        ),
       onPressed: () => formvalidate(context),
        label: Text("Submit"),
      ),
    ),
  );
}
}

void formvalidate(BuildContext context)
{
   if (_appointtime == null)
    {
      _appointtime = new DateTime.now().toString();
    }
    List<String?> values = [_fullname.text.trim(),_phone.text.trim(),_street.text.trim(),
    _city.text.trim(),_zipcode.text.trim(),_email.text.trim(),_doctorname.text.trim(),_appointtime.toString()];
    print(values);
    insertappointmentvalue(values,context);
  }
