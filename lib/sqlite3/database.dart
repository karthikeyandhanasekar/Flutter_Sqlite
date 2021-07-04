
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
      join(dbpath,'auth.db')
      ,version: 1,
    onCreate: (Database db, int version) async
    {
      await db.execute("create table users (email varchar2(50) PRIMARY KEY , password varchar2(100)) ");
    }); 
    print(dbpath);
    return database;
}
 Future<void> insertvalue(String _email,String _password,BuildContext context) async
 {
   String _sql = 'insert into users values(?,?)';
  Database db =  await createdatabase();
  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[_email,_password]);
    print("inserted : $id");
  }
  );
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => Show())
  );
 }

 Future<List<User>> retrivedata() async 
 {
   Database db = await createdatabase();
     String _sql = 'select * from users';
   List<Map> list = await  db.rawQuery(_sql);
   print(list);
   return list.map((e) => User.fromMap(e)).toList();

 
 }

