import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/loginui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqliteapp/sqlite3/database.dart';


TextEditingController _emailcontroller = new TextEditingController();
TextEditingController _passwordcontroller = new TextEditingController();


class Login extends StatefulWidget
{
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
 
 @override
  void initState() {
    createdatabase();
    super.initState();
  }
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Login',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),),
        elevation: 20.0,
      ),
      body:Center(
        child: SizedBox(
          height: 250,
          width: 380,
          child: Card(
      color: Theme.of(context).backgroundColor,
            borderOnForeground: false,
            elevation: 20.0,
            shadowColor: Colors.blueAccent,
            child: new Form(
                child:ListView(
                  children: <Widget>[
                    SizedBox(
                      height:1 
                    ),
                    CustomTextField.TextFieldType(context,_emailcontroller,Icon(Icons.email_outlined),TextInputType.emailAddress,"Email"),
                    SizedBox(
                      height:1 
                    ),
                   CustomTextField.TextFieldType(context,_passwordcontroller,Icon(Icons.password_outlined),TextInputType.text,"Email",pass: true),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min ,
                      children: <Widget>[
                            SubmitButton(context),
                            Gotregister(context)
                      ],
                    ),
                     
                  ],
                )
            ),
          ),
        ),
      )
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
      padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: ElevatedButton.icon(
      
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          elevation: 3,
        ),
        onPressed: () => loginvalidate(_emailcontroller.text.trim(), _passwordcontroller.text.trim(),context),
        label: Text("Submit"),
      ),
    ),
  );
}

Widget Gotregister(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: ElevatedButton(
        onPressed:()=> register(context), 
        child: Text('Register',
        style: TextStyle(
          fontSize: 20.0
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
