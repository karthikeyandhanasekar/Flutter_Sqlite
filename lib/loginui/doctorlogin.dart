import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/loginui/doctorregistration.dart';
import 'package:sqliteapp/sqlite3/database.dart';


TextEditingController _emailcontroller = new TextEditingController();
TextEditingController _passwordcontroller = new TextEditingController();
final _form = GlobalKey<FormState>();

class DoctorLogin extends StatefulWidget
{
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
         title: Text('Doctor Login',
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
  Widget doctorregister(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 5, 100, 20),
      child: OutlinedButton(
        
        onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorRegistration())      ),
        child: Text('Register',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black54,
          fontWeight: FontWeight.w900,
        ),),
        )
    ),
  );
}

  Widget AuthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            Container(
              
              child: Image.asset('assets/images/heartbeat.png',
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
                key: _form,
                  child:ListView(
                    children: <Widget>[
                     CustomTextField.TextFieldType(context,_emailcontroller,Icon(Icons.people_alt_outlined),TextInputType.emailAddress,"Name"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.TextFieldType(context,_passwordcontroller,Icon(Icons.password_outlined),TextInputType.text,"Password",pass: true),
                      SizedBox(
                        height: 10,
                      ),
                      SubmitButton(context),
                     // doctorregister(context),
                     dlist(context)
                      
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
final database = Provider.of<Data>(context,listen:false);


  if (_form.currentState!.validate())
  {
database.doctorloginvalidate(_emailcontroller.text.trim(),_passwordcontroller.text.trim(),context);

  }
}



Widget dlist(BuildContext context)
{
final database = Provider.of<Data>(context,listen:false);


  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: ElevatedButton.icon(
                    
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          elevation: 3,
        ),
       onPressed: () => database.fulllist(),
        //onPressed: () => retrivedata(),

        label: Text("List"),
      ),
    ),
  );
}

