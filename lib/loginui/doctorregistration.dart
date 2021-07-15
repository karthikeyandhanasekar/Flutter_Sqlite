import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/loginui/doctortime.dart';
import 'package:sqliteapp/sqlite3/database.dart';

TextEditingController _doctornamecontroller = new TextEditingController();
TextEditingController _emailcontroller = new TextEditingController();
TextEditingController _passwordcontroller = new TextEditingController();

final _formkey = GlobalKey<FormState>();
class DoctorRegistration extends StatefulWidget
{
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
         title: Text('DoctorRegistration',
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
                      CustomTextField.TextFieldType(context,_doctornamecontroller,Icon(Icons.people_outline),TextInputType.text,"Name"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.EmailInput(context,_emailcontroller,Icon(Icons.email_outlined),TextInputType.emailAddress,"Email"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.TextFieldType(context,_passwordcontroller,Icon(Icons.password_outlined),TextInputType.text,"Password",pass: true),
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
 @override
  void dispose() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
    super.dispose();
  }
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
  if (_formkey.currentState!.validate())
  {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DoctorTime(doctorname :_doctornamecontroller.text.trim(),email : _emailcontroller.text.trim(),password :_passwordcontroller.text.trim())));  
//doctorinsert(_doctornamecontroller.text.trim(), _emailcontroller.text.trim(),_passwordcontroller.text.trim(),context);

  }
 } 

