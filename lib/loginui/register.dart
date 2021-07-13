import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/sqlite3/database.dart';


TextEditingController _emailcontroller = new TextEditingController();
TextEditingController _passwordcontroller = new TextEditingController();


class Register extends StatefulWidget
{
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
         title: Text('Register',
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
              
              child: Image.asset('assets/images/doctor-removepg.png',
              fit: BoxFit.fitHeight,
              height:  (window.physicalSize.height)/10,
              width: window.physicalSize.width,              
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:SizedBox(
              height: 300,
              child: new Form(
                  child:ListView(
                    children: <Widget>[
                     CustomTextField.TextFieldType(context,_emailcontroller,Icon(Icons.email_outlined),TextInputType.text,"Email"),
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
       onPressed: () => insertvalue(_emailcontroller.text.trim(),_passwordcontroller.text.trim(),context),
        //onPressed: () => retrivedata(),

        label: Text("Submit"),
      ),
    ),
  );
}