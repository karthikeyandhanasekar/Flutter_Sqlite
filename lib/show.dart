


import 'package:flutter/material.dart';
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
      body: FutureBuilder(
        future:appointmentretrivedata(),
        builder: (BuildContext context , AsyncSnapshot<List<User>> snapshot)
        {
          if(snapshot.hasData)
          {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context,int index)
            {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data![index].fullname) ,
                  subtitle: Text(snapshot.data![index].datetime),
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
        ),
    );
  }
}