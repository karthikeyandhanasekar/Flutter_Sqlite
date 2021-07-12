
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/userdetails.dart';
import 'package:sqliteapp/show.dart';

class User
{
  final String email;
  final String password;
  User(
    {
      required this.email,
      required this.password,
    }
  );
  User.fromMap(Map<dynamic, dynamic> res):
  this.email=res["email"],
  this.password = res["password"];


  Map<String, Object?> toMap() {
    return {'email' : email , 'password' : password};
  }
}




Future<Database> createdatabase() async {
  print("create table");
  var dbpath = await getDatabasesPath() ;

    Database database = await openDatabase(
      join(dbpath,'hospital.db')
      ,version: 1,
    onCreate: (Database db, int version) async
    {
      await db.execute("create table users (email varchar2(50) PRIMARY KEY , password varchar2(100)) ");
      await db.execute("create table appointment (fullname varchar2(100) , phone varchar2(10) , Street varchar2(100),city varchar2(100),zipcode varchar2(6),email varchar2(100),doctorname varchar2(100),datetime varchar2(100))");
    print("created");
    }); 
    print(dbpath);
    return database;
}


 Future<void> insertvalue(String _email,String _password,BuildContext context) async
 {
   try
   {
 String _sql = 'insert into users values(?,?)';
  Database db =  await createdatabase();
 await  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[_email,_password]);
    print("inserted : $id");
    if (id != 0)
    {
    Navigator.of(context).pop();
    }
  }
  );
   }
   catch(e,s)
   {
    await errordialog(context, "Invalid Register", "Try different email or password");

   }
  
 }
 Future<List<User>> retrivedata() async 
 {
   Database db = await createdatabase();
     String _sql = 'select * from users';
   List<Map> list = await  db.rawQuery(_sql);
   print(list);
   return list.map((e) => User.fromMap(e)).toList();
 }

  Future<void> loginvalidate(String _email ,String _password,BuildContext context) async 
 {
   Database db = await createdatabase();
     String _sql = 'select * from users where email = ? and password = ?';
   List<Map> _list= await db.rawQuery(_sql,[_email,_password]); 
   if (_list.isNotEmpty)
   {
     print("list not empty and validate");
     //change here
      Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => UserDetails(email : _email))
  );
   }
   else
   {
     print("Login Failed");
      await errordialog(context, "Login failed",'');

   } 
   
 }

  