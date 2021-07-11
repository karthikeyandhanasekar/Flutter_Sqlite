
import 'package:flutter/material.dart';

class CustomTextField 
{
static Widget TextFieldType(BuildContext context,TextEditingController _controller,Icon _icon,TextInputType _keyboardtype  ,String _hint,{bool pass=false})
{
  return ListTile(
    leading : _icon,
    title : TextFormField(
      controller: _controller,
      obscureText: pass ,
      autofocus: true,
      keyboardType: _keyboardtype,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
         hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
      )
    )
  );
} 
}