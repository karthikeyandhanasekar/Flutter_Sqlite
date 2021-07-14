


import 'package:flutter/material.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';

class DoctorShow extends StatefulWidget {

 final String name;
  DoctorShow({required this.name});
  
  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<DoctorShow> {
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      backgroundColor: Theme.of(context).bottomAppBarColor,

      ),
      body: ListTileWidget(context),
    );
  }
  


  FutureBuilder<List<User>> ListTileWidget(BuildContext context) {
    return FutureBuilder(
      future:Doctorschedule(widget.name),
      builder: (BuildContext context , AsyncSnapshot<List<User>> snapshot)
      {
        if(snapshot.hasData)
        {
            
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (BuildContext context,int index)
          {
            String value = "DateTime : " + snapshot.data![index].datetime + "\nContact : " + snapshot.data![index].phone + "\nDoctor Name : " + snapshot.data![index].doctor ;
            return Card(
              elevation: 5.0,
              
              child: ListTile(
                dense: true,
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(2, 2)),
                  
                ),
                title: Text(snapshot.data![index].fullname,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                ) ,
                subtitle: Text("\t" +"\t"  +"\t"  + snapshot.data![index].datetime,
                style: TextStyle(
                      color: Colors.black,
              
                      fontSize: 18.0,
                    ),
                
                ),
                onTap: () => errordialog(context,snapshot.data![index].fullname ,value) ,
              ),
            );
          });

        }
        else
        {
          //list empty
          return Center(child: CircularProgressIndicator(),);
        }
        
      }
      );
  }
  
}