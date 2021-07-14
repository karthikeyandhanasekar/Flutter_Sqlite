
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/doctorlist.dart';
import 'package:sqliteapp/userdetails.dart';
import 'package:sqliteapp/show.dart';

   List<String> doctors = [];

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

class doctor
{
  final String name;
  doctor({required this.name});
  doctor.fromMap(Map<dynamic,dynamic> res):
  this.name = res["name"];

  Map<String, Object?> toMap() {
    return {'name' : name};
  }


}




Future<Database> createdatabase() async {
  print("create table");
  var dbpath = await getDatabasesPath() ;

    Database database = await openDatabase(
      join(dbpath,'health.db')
      ,version: 2,
    onCreate: (Database db, int version) async
    {
      await db.execute("create table users (email varchar2(50) PRIMARY KEY , password varchar2(100)) ");
      await db.execute("create table doctors (name varchar2(100),email varchar2(50) PRIMARY KEY , password varchar2(100)) ");
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
      await errordialog(context, "Login failed",'Invalid Creditionals');

   } 
   
 }

  Future<void> doctorinsert( String _name ,String _email,String _password,BuildContext context) async
 {
   try
   {
     String name = "Dr." + _name;
 String _sql = 'insert into doctors values(?,?,?)';
  Database db =  await createdatabase();
 await  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[name,_email,_password]);
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

 Future<void> doctorloginvalidate(String _name ,String _password,BuildContext context) async 
 {
        String name = "Dr." + _name;

   Database db = await createdatabase();
     String _sql = 'select * from doctors where name = ? and password = ?';
   List<Map> _list= await db.rawQuery(_sql,[name,_password]); 
   print(_list);
   if (_list.isNotEmpty)
   {
     print("list not empty and validate");
     //change here
      Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => DoctorShow(name: name))
  );
   }
   else
   {
     print("Login Failed");
      await errordialog(context, "Login failed",'Invalid Creditionals');

   } 
   
 }

 Future<List> doctorlist() async 
 {
   Database db = await createdatabase();
     String _sql = 'select name from doctors';
   List list = await  db.rawQuery(_sql,);
   //print(list);
   doctors=[];
   for(var doct in list)
   {
     doctors.add(""+doct["name"]);
   }
   print("no");
   print(doctors);
   return list.map((e) => doctor.fromMap(e)).toList();
 }

 List<String> Doctorlist()
 {
   doctorlist();
   print("Hello");
   //print(doctors);
   return doctors;
 }


