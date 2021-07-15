import 'package:flutter/material.dart';

infodialog(BuildContext context,String title,String? content) 
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

errordialog(BuildContext context,String title,String? content)
{
 return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(title),
          duration: Duration(milliseconds: 5000),
          
          ));
} 
