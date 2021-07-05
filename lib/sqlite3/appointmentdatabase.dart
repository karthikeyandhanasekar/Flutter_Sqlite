
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqliteapp/appointmentform.dart';
import 'package:sqliteapp/show.dart';
import 'package:sqliteapp/sqlite3/database.dart';

class User
{
  final String fullname;
    final String phone;

  final String street;
  final String city;
  final String zipcode;


  final String email;
  final String doctor;
  final dynamic datetime;
  User( 
    {
      required this.email,
     required this.fullname,
     required this.phone,
     required this.street,
     required this.city,
     required this.zipcode,
     required this.doctor,
     required this.datetime,
    }
  );
  
  User.fromMap(Map<dynamic, dynamic> res):
  
  this.email=res["email"],
  this.fullname = res['fullname'],
  this.phone = res['phone'],
  this.street = res['Street'],
  this.city = res['city'],
  this.zipcode = res['zipcode'],
  this.doctor = res['doctorname'],
  this.datetime = res['datetime'];

  Map<String, Object?> toMap() {
    return {
      'fullname' : fullname,
      'phone' : phone,
      'email' : email,
      'street' : street,
      'city' : city,
      'zipcode' : zipcode,
      'doctor' : doctor,
      'datetime' : datetime.toString(),
      
    };
  }
}

 Future<void> insertappointmentvalue(List<String?> values,BuildContext context) async
 {
   String _sql = 'insert into appointment values(?,?,?,?,?,?,?,?)';
  Database db =  await createdatabase();
  db.transaction((txn) async
  {
    int id =  await txn.rawInsert(_sql,[values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7]]);
    print("inserted : $id");
    if (id != 0)
    {
      print("insert success $id ");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Show())
      );
    }
    else
    {
      print("not insert success");
    }
  }
  );
 }
 Future<List<User>> appointmentretrivedata() async 
 {
   Database db = await createdatabase();
     String _sql = 'select * from appointment';
   List<Map> list = await  db.rawQuery(_sql);
   print(list);
   return list.map((e) => User.fromMap(e)).toList();
 }