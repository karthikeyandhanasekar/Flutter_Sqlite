


import 'package:flutter/material.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';

class Show extends StatefulWidget {

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<Show> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
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
              child: ListTile(
                title: Text(snapshot.data![index].fullname) ,
                subtitle: Text(snapshot.data![index].datetime),
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