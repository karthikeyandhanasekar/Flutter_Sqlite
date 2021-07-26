
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/doctorlist.dart';
import 'package:sqliteapp/loginui/doctorlogin.dart';
import 'package:sqliteapp/loginui/login.dart';
import 'package:sqliteapp/userdetails.dart';
import 'package:sqliteapp/show.dart';

   List<String> doctors = [];
      List<String> timmings = [];

class doctortime
{
  final String fn;
  final String an;
  final String en;
  doctortime({required this.fn, required this.an, required this.en});
  doctortime.fromMap(Map<dynamic,dynamic> res):
  this.fn = res["FN"],
  this.an=res["AN"],
  this.en = res["EN"];
  

  Map<String, Object?> toMap() {
    return {'FN' : fn , 'AN' : an ,'EN' : en};
  }
}
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


abstract class Data
{
  static Future<Database> createdatabase() async
  {
    //print("create table");
  var dbpath = await getDatabasesPath() ;

    Database database = await openDatabase(
      join(dbpath,'Health.db')
      ,version: 2,
    onCreate: (Database db, int version) async
    {
    await db.execute("DROP TABLE IF EXISTS doctors");

      await db.execute("create table users (email varchar2(50) PRIMARY KEY , password varchar2(100)) ");
      await db.execute("create table doctors (name varchar2(100) ,email varchar2(50) , password varchar2(100),FN varchar2(100), AN varchar2(100), EN varchar2(100),PRIMARY KEY(name,email)) ");
      await db.execute("create table appointment (fullname varchar2(100) , phone varchar2(10) , Street varchar2(100),city varchar2(100),zipcode varchar2(6),email varchar2(100),doctorname varchar2(100),datetime varchar2(100))");
   // print("created");
    }
    ); 
    
    //print(dbpath);
    return database;

  }
   Future<void> insertvalue(String _email,String _password,BuildContext context);
    Future<List<User>> retrivedata();
      Future<void> loginvalidate(String _email ,String _password,BuildContext context);

  Future<void> doctorinsert( String _name ,String _email,String _password,String fn,String an,String en,  BuildContext context) ;
   Future<void> doctorloginvalidate(String _name ,String _password,BuildContext context) ;
 Future<List> doctorlist() ;
 List<String> Doctorlist();
 List<String> timminglist(String? name);
  Future<List> timming(String name) ;
  Future<void> fulllist();



}
class database implements Data
{
  
  


 Future<void> insertvalue(String _email,String _password,BuildContext context) async
 {
   try
   {
 String _sql = 'insert into users values(?,?)';
  Database db =  await Data.createdatabase();
 await  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[_email,_password]);
    //print("inserted : $id");
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
    Navigator.of(context).pop();

   }
  
 }
 Future<List<User>> retrivedata() async 
 {
   Database db = await Data.createdatabase();
     String _sql = 'select * from users';
   List<Map> list = await  db.rawQuery(_sql);
   print(list);
   for (var lis in list )
   {
     //print(lis);
   }
   return list.map((e) => User.fromMap(e)).toList();
 }

  Future<void> loginvalidate(String _email ,String _password,BuildContext context) async 
 {
   Database db = await Data.createdatabase();
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
     await  errordialog(context, "Login failed",'Invalid Creditionals');

   } 
   
 }

  Future<void> doctorinsert( String _name ,String _email,String _password,String fn,String an,String en,  BuildContext context) async
 {
   try
   {
     String name = "Dr." + _name;
 String _sql = 'insert into doctors values(?,?,?,?,?,?)';
  Database db =  await Data.createdatabase();
 await  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[name,_email,_password,fn,an,en]);
    //print("inserted : $id");
    if (id != 0)
    {
    Navigator.of(context).pop();
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

   Database db = await Data.createdatabase();
     String _sql = 'select * from doctors where name = ? and password = ?';
   List<Map> _list= await db.rawQuery(_sql,[name,_password]); 
   print(_list);
   if (_list.isNotEmpty)
   {
    // print("list not empty and validate");
     //change here
      Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => DoctorShow(name: name))
  );
   }
   else
   {
   //  print("Login Failed");
      await errordialog(context, "Login failed",'Invalid Creditionals');

   } 
   
 }

 Future<List> doctorlist() async 
 {
   Database db = await Data.createdatabase();
     String _sql = 'select name from doctors';
   List list = await  db.rawQuery(_sql,);
   //print(list);
   doctors=[];
   for(var doct in list)
   {
     doctors.add(""+doct["name"]);
   }
  // print("no");
   //print(doctors);
   return list.map((e) => doctor.fromMap(e)).toList();
 }

 Future<List<doctortime>> timming(String? name) async 
 {
   Database db = await Data.createdatabase();
     String _sql = 'select fn,an,en from doctors where name= ?';
   List list = await  db.rawQuery(_sql,[name]);
   timmings=[];
   for(var doct in list)
   {
     for (var attr in ["FN","AN","EN"])
     {
     timmings.add(""+doct[attr]);
     }
   }
   //print(timmings);
   
   return list.map((e) => doctortime.fromMap(e)).toList();
 }
 List<String> timminglist(String? name)
 {
   timming(name);
  // print("Hello");
   //print(timmings);
   return timmings;
 }

 List<String> Doctorlist()
 {
   doctorlist();
   //print("Hello");
   //print(doctors);
   return doctors;
 }
/*
void droptable() async
{
     Database db = await createdatabase();
     await db.rawQuery("Drop table users");
     print("deleted");
}
*/

Future<void> fulllist() async
{
 Database db = await Data.createdatabase();
     String _sql = 'select * from doctors ';
   List list = await  db.rawQuery(_sql,[]);
   for(var doct in list)
   {
     
    print(doct);
   }
}

}
