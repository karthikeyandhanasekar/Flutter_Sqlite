import 'package:flutter/material.dart';

errordialog(BuildContext context,String title,String? content) 
 {
  print("error dialog");
  return showDialog(
    context: context,
     builder: (context) 
     {
       return  AlertDialog(
         title: Text(title),
         actions: [
           TextButton(
             onPressed: () => Navigator.of(context).pop(), 
             child: Text('ok')),    
         ],
         content: Text(content!),
   );
     }
     
     
     ); 
   }