
import 'package:flutter/material.dart';
import 'package:sqliteapp/userdetails.dart';

class CustomTextField 
{
  static RegExp emailvalid = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

static Widget TextFieldType(BuildContext context,TextEditingController _controller,
Icon _icon,TextInputType _keyboardtype  ,String _hint, 
{bool pass=false})
{
  return ListTile(
    leading : _icon,
    title : TextFormField(
      controller: _controller,
      obscureText: pass ,
      keyboardType: _keyboardtype,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
        hintText: _hint,
         hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
      ),
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Required";
        }
       return null;
      } 
    )
  );
} 

static Widget EmailInput(BuildContext context,TextEditingController _controller,
Icon _icon,TextInputType _keyboardtype  ,String _hint, 
{bool pass=false})
{
  return ListTile(
    leading : _icon,
    title : TextFormField(
      controller: _controller,
      obscureText: pass ,
      keyboardType: _keyboardtype,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
        hintText: _hint,
         hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
      ),
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Required";
        }
        else if(!emailvalid.hasMatch(value))
        {
          return "Invalid Email";
        }
       return null;
      } 
    ));
}

static Widget PhoneInput(BuildContext context,TextEditingController _controller,
Icon _icon,TextInputType _keyboardtype  ,String _hint, 
{bool pass=false})
{
  return ListTile(
    leading : _icon,
    title : TextFormField(
      controller: _controller,
      obscureText: pass ,
      keyboardType: _keyboardtype,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
        hintText: _hint,
         hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
      ),
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Required";
        }
        else if(value.length != 10)
        {
          return "Invalid Phone Number";
        }
       return null;
      } 
    ));
}
static Widget ZipInput(BuildContext context,TextEditingController _controller,
Icon _icon,TextInputType _keyboardtype  ,String _hint, 
{bool pass=false})
{
  return ListTile(
    leading : _icon,
    title : TextFormField(
      controller: _controller,
      obscureText: pass ,
      keyboardType: _keyboardtype,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
        hintText: _hint,
         hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
      ),
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Required";
        }
        else if(value.length != 6)
        {
          return "Invalid ZipCode";
        }
       return null;
      } 
    ));
}
}