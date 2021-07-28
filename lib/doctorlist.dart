


import 'package:flutter/material.dart';
import 'package:sqliteapp/customwidget/dialog.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';

class DoctorShow extends StatefulWidget {

 final String name;
  DoctorShow({required this.name});
  
  @override
  _nameState createState() => _nameState();
}
String drawername = '';

class _nameState extends State<DoctorShow> {
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        
      backgroundColor: Theme.of(context).bottomAppBarColor,

      ),
      body: ListTileWidget(context),

    drawer: Drawer(
      child: ListView(  
    padding: EdgeInsets.zero,  
    children: <Widget>[  
      Container(
        height: 100.0,
        child: DrawerHeader(  

          decoration: BoxDecoration(
            color:  Theme.of(context).bottomAppBarColor,
          
          ),
          child: Column(
            children: [
//Image.asset('assets/images/doctorhello.png',fit: BoxFit.fitHeight,height: 100,),
                Text(widget.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  decorationStyle: TextDecorationStyle.double
                ),
                ),

            ],)
        ),
      ),
      ListTile(
        leading: Icon(Icons.messenger),
        title: Text("Menu 1"),
        onTap: () => Navigator.of(context).pop(),
      )

    ]
      ),  
    ),


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

            String value = "Email : " + snapshot.data![index].email + "\nContact : " + snapshot.data![index].phone + "\nStreet Name : " + snapshot.data![index].street ;
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
                onLongPress: () => infodialog(context,snapshot.data![index].fullname ,value) ,
                onTap: () => attendancedialog(context,snapshot.data![index].fullname ,value,snapshot.data![index].datetime),

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