import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/sqlite3/database.dart';

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
attendancedialog(BuildContext context,String title,String? content,String _date) 
 {
   final database = Provider.of<Data>(context, listen: false);
  print("attendance dialog");
  return showDialog(
    context: context,
     builder: (context) 
     {
       return  AlertDialog(
         title: Text(title),
         actions: [
           TextButton(
             onPressed: () => database.updatepatientstatus(_date, "Present"), 
             child: Text('Present')),
             TextButton(
             onPressed: () => database.updatepatientstatus(_date, "Absent"), 
             child: Text('Absent')),    
         ],
         content: Text(content!),
   );
     }
     
     
     ); 
   }
