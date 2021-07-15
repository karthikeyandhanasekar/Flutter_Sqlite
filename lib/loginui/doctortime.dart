import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/sqlite3/database.dart';

String fn='',an='',en='';
final _formkey = GlobalKey<FormState>();
class DoctorTime extends StatefulWidget
{
  String doctorname,email,password;
  DoctorTime({ required this.doctorname,required this.email,required this.password});

  _DoctorTimeState createState() => _DoctorTimeState();
}

class _DoctorTimeState extends State<DoctorTime> {

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
         title: Text('Select Timmings',
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
            Container(
              
              child: Image.asset('assets/images/doctorreg.jpeg',
              fit: BoxFit.fitHeight,
              height:  (window.physicalSize.height)/10,
              width: window.physicalSize.width,              
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:SizedBox(
              height: window.physicalSize.height,
              child: new Form(
                key: _formkey,
                  child:ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.timeline_outlined),
                        title:DateTimePicker(
                    type: DateTimePickerType.time,                    
                    timeLabelText: 'Morning Slot',
                    
                    icon: Icon(Icons.access_time_filled_outlined),
                    onSaved: (value)
                    {
                        fn = value!.toString();
                    },
                    onChanged: (value)
                    {
                      fn = value.toString();
                      print(fn);

                    },
                  ), 
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.timeline_outlined),
                        title:DateTimePicker(
                    type: DateTimePickerType.time,                    
                    timeLabelText: 'Afternoon Slot',
                    
                    icon: Icon(Icons.access_time_filled_outlined),
                    onSaved: (value)
                    {
                        an = value!.toString();
                    },
                    onChanged: (value)
                    {
                      an = value.toString();
                      print(an);

                    },
                  ), 
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.timeline_outlined),
                        title:DateTimePicker(
                    type: DateTimePickerType.time,                    
                    timeLabelText: 'Evening Slot',
                    
                    icon: Icon(Icons.access_time_filled_outlined),
                    onSaved: (value)
                    {
                        en = value!.toString();
                    },
                    onChanged: (value)
                    {
                      en = value.toString();
                      print(en);

                    },
                  ), 
                      ),
                      SizedBox(
                        height: 10,
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
       onPressed: () => Submit(context),
        //onPressed: () => retrivedata(),

        label: Text("Submit"),
      ),
    ),
  );
}

 Submit(BuildContext context) 

{
     final database = Provider.of<Data>(context,listen:false);

  if (_formkey.currentState!.validate())
  {
    
   database.doctorinsert(widget.doctorname,widget.email,widget.password,fn,an,en,context);

  }
 } 

}