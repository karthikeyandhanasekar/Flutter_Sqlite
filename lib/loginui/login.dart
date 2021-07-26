import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/loginui/doctorlogin.dart';
import 'package:sqliteapp/loginui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqliteapp/sqlite3/database.dart';

import 'doctorregistration.dart';


TextEditingController _emailcontroller = new TextEditingController();
TextEditingController _passwordcontroller = new TextEditingController();

  final _form = GlobalKey<FormState>();

class Login extends StatefulWidget
{
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {

 @override
  void initState() {
    //droptable();
    Data.createdatabase();
    print("init");
    super.initState();
  }
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
        title: Text('Login',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),),
        elevation: 20.0,
      ),
      body:AuthPage(context),

    );
  }
  @override
  void dispose() {
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
        label: Text("Submit"),
      ),
    ),
  );
}
 Submit(BuildContext context) 
{
   final database = Provider.of<Data>(context, listen: false);


  if (_form.currentState!.validate())
  {
     database.loginvalidate(_emailcontroller.text.trim(), _passwordcontroller.text.trim(),context);

  }
  else
  {
  }
} 

Widget Gotregister(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 5, 100, 20),
      child: OutlinedButton(
        
        onPressed:()=> register(context), 
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

register(BuildContext context)
{
  return 

     Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => Register())
  ); 
}
Widget doctorlogin(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 5, 100, 20),
      child: OutlinedButton(
        
        onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorLogin())      ),
        child: Text('Doctor Login',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black54,
          fontWeight: FontWeight.w900,
        ),),
        )
    ),
  );
}

Widget AdminLogin(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 5, 100, 20),
      child: OutlinedButton(
        
        onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorRegistration())      ),
        child: Text('Admin Login',
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

              child: Image.asset('assets/images/doctorhello.png',
              fit: BoxFit.fitHeight,
              height:  (window.physicalSize.height)/10,
              width: window.physicalSize.width,              
              ),
            ),
             SizedBox(
                        height: 10,
                      ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
            child:SizedBox(
              height: window.physicalSize.height,
              child: new Form(
                key: _form,
                  child:ListView(
                    children: <Widget>[
                     CustomTextField.EmailInput(context,_emailcontroller,Icon(Icons.email_outlined),TextInputType.emailAddress,"Name"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.TextFieldType(context,_passwordcontroller,Icon(Icons.password_outlined),TextInputType.text,"Password",pass: true),
                      SizedBox(
                        height: 10,
                      ),
                      SubmitButton(context),
                      Gotregister(context),
                      doctorlogin(context),
                      AdminLogin(context),

                    ],
                  )
              ),
            )
    
          ),
        ],
      ),
    );
  }
