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
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 25, 10, 100),
          child:SizedBox(
            height: 300,
            child: new Form(
                child:ListView(
                  children: <Widget>[
                    EmailInput(),
                    SizedBox(
                      height:1 
                    ),
                    PasswordInput(),
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
          )

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
Widget EmailInput()
{
  return Padding(
    padding: EdgeInsets.all(25.0),
    child:    TextFormField(
      autovalidateMode: AutovalidateMode.always, 
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
      validator: (String? value)
      {
        
        return value != null ? null: "Please Enter your email" ; 
      },
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
            autovalidateMode: AutovalidateMode.always, 

      keyboardType: TextInputType.name,
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
      validator: (String? value)
      {
        
        return value != null ? null: "Please Enter your password" ; 
      },
    ),
  );
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
