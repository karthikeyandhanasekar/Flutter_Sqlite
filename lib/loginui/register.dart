import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
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
      body:Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 100),
          child:SizedBox(
            height: 300,
            child: new Form(
                child:ListView(
                  children: <Widget>[
                    EmailInput(),
                    SizedBox(
                      height: 10,
                    ),
                    PasswordInput(),
                    SizedBox(
                      height: 10,
                    ),
                    SubmitButton(context)
                    
                  ],
                )
            ),
          )

        ),
      )
    );
  }

}
Widget EmailInput()
{
  return Padding(
    padding: EdgeInsets.all(25.0),
    child:    TextFormField(
      controller: _emailcontroller,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      obscureText: false,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
          hintText: 'Email Address',
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          /*enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(
              color: Colors.black,
            ) )*/
      ),
    ),
  );
}
Widget PasswordInput()
{
  return Padding(
    padding: EdgeInsets.all(25.0),
    child:
    TextFormField(
      controller: _passwordcontroller,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
       decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          /*enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(
              color: Colors.black,
            ) )*/
      ),
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
       onPressed: () => insertvalue(_emailcontroller.text.trim(),_passwordcontroller.text.trim(),context),
        //onPressed: () => retrivedata(),

        label: Text("Submit"),
      ),
    ),
  );
}