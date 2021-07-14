


import 'package:flutter/material.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';

class Show extends StatefulWidget {

 /* final String name;
  Show({required this.name});
  void printdata()
  {}*/
  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<Show> {
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      backgroundColor: Theme.of(context).bottomAppBarColor,

      ),
      body: ListTileWidget(context),
    );
  }
  


  FutureBuilder<List<User>> ListTileWidget(BuildContext context) {
    return FutureBuilder(
      future:appointmentretrivedata(context),
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