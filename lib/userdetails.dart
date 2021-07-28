
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/customwidget/textfield.dart';
import 'package:sqliteapp/show.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';

import 'sqlite3/database.dart';

final  _formKey = GlobalKey<FormState>();
String? _doctorname;
String? _date;

TextEditingController _fullname = new TextEditingController();
TextEditingController _phone = new TextEditingController();
TextEditingController _street = new TextEditingController();
TextEditingController _city = new TextEditingController();
TextEditingController _zipcode = new TextEditingController();
TextEditingController _email = new TextEditingController();
var currentyear = new DateTime.now().year;
String? _appointtime;
class UserDetails extends StatefulWidget
{
  final String email;

   UserDetails({ required this.email}); 
   

  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {


@override
  void initState() {
    print("init");
 /*    //Doctorlist();
  setState(() {
      values = Data.Doctorlist();
    });*/
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _fullname.clear();
    _phone.clear();
    _street.clear();
    _city.clear();
    _zipcode.clear();
    _email.clear();
    super.dispose();
  }
  
  @override
  Widget build (BuildContext context)
  {
    
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      actions: [
        TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Show())), 
        child: Text("Display",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
        ),),)
      ],
         title: Text('Appointment',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),),
titleTextStyle: TextStyle(
  color: Colors.black,

) ,
        elevation: 20.0,

      ),
      body:   AuthPage(context)

    );
         

      
  }
  Widget AuthPage(BuildContext context) {
      final database = Provider.of<Data>(context,listen:false);

    return SingleChildScrollView(
      child: Column(
        children: [
    
          Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child:SizedBox(
              height: double.maxFinite,
              child: new Form(
                key: _formKey,
                  child:ListView(
                    children: <Widget>[
                     CustomTextField.TextFieldType(context,_fullname,Icon(Icons.text_fields_outlined),TextInputType.text,"Full Name"),
                      SizedBox(
                        height: 10,
                      ),
                     CustomTextField.PhoneInput(context,_phone,Icon(Icons.phone_callback),TextInputType.phone,"Number",),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField.TextFieldType(context,_street,Icon(Icons.streetview_outlined),TextInputType.text,"Street Address",),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded
                          (child: CustomTextField.TextFieldType(context,_city,Icon(Icons.location_city_outlined),TextInputType.text,"City",)),
                      SizedBox(
                        height: 10,
                      ),
                        Expanded
                          (child: CustomTextField.ZipInput(context,_zipcode,Icon(Icons.code_outlined),TextInputType.number,"ZipCode",)),
                      SizedBox(
                        height: 10,
                      ),
                       ],),
                        SizedBox(
                        height: 10,
                      ),
                       DoctorSelection(database),
                     // CustomTextField.TextFieldType(context,_doctorname,Icon(Icons.people_alt_outlined),TextInputType.text,"Doctor Name"),
                      SizedBox(
                        height: 10,
                      ),
                  if (_doctorname != null) TimesSelection(database) else SizedBox(),
                  SizedBox(height: 10,),
                  ListTile(
                        leading: Icon(Icons.timeline_outlined),
                        title:DateTimePicker(
                    type: DateTimePickerType.date,                    
                    timeLabelText: 'Morning Slot',
                    firstDate: DateTime(DateTime.now().year),
                    lastDate:  DateTime(DateTime.now().year+10),
                    
                    onSaved: (value)
                    {
                        _date = value!.toString();
                    },
                    onChanged: (value)
                    {
                      _date = value.toString();
                      print(_date);

                    },
                  ), 
                      ),
                  SubmitButton(context)
                      
                    ],
                  )
              ),
            )
    
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<dynamic>> DoctorSelection(Data database) {
    return FutureBuilder(
                       future: database.doctorlist() ,
                       builder: (context, AsyncSnapshot<List> snapshot) {
                         if (snapshot.hasData)
                         {
                         
                         return ListTile(
                           leading: Icon(Icons.health_and_safety_outlined),
                           title: DropdownButton<String>(
                           focusColor:Colors.white,
                           value: _doctorname,
                           //elevation: 5,
                           style: TextStyle(color: Colors.white),
                           iconEnabledColor:Colors.black,
                           items:database.Doctorlist().map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:TextStyle(color:Colors.black,fontSize: 20.0,
                         ),),
                             );
                           }).toList(),
                           hint:Text(
                             "Doctors",
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 20,
                                 ),
                           ),
                           onChanged: ( value) {
                             setState(() {
                               print(value);
                               _doctorname = value;
                               _appointtime = '';
                     
                             });
                           },
                         ),
                         );
                         
                       }
                       else
                       {
                         return Text("None");
                       }
                       }
                     );
  }
FutureBuilder<List<dynamic>> TimesSelection(Data database) {
   
    return FutureBuilder(
                       future: database.timming(_doctorname!) ,
                       builder: (context, AsyncSnapshot<List> snapshot) {
                         if (snapshot.hasData)
                         {
                         return ListTile(
                           leading: Icon(Icons.health_and_safety_outlined),
                           title: DropdownButton<String>(
                           focusColor:Colors.white,
                          
                           //elevation: 5,
                           
                           style: TextStyle(color: Colors.white),
                           iconEnabledColor:Colors.black,
                           items:database.timminglist(_doctorname).map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:TextStyle(color:Colors.black,fontSize: 20.0,
                         ),),
                             );
                           }).toList(),
                           hint:Text(
                             _appointtime!,
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 20,
                                 ),
                           ),
                           onChanged: ( value) {
                             setState(() {
                               print(value);
                               _appointtime = value;
                               print("Appointment is ");
                               print(_appointtime);
                     
                             });
                           },
                           value: database.timminglist(_doctorname).first,
                         ),
                         );
                         
                       }
                       else
                       {
                         return Text("None");
                       }
                       }
                     );
  }
  Widget SubmitButton(BuildContext context)
{
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: ElevatedButton.icon(
                    
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          elevation: 3,
        ),
       onPressed: () => formvalidate(context,widget.email),
        label: Text("Submit"),
      ),
    ),
  );
}
}

void formvalidate(BuildContext context,String email)
{
  if (_formKey.currentState!.validate())
  {
if (_appointtime == null && _date == null)
    {
      _appointtime = new DateTime.now().toString();
    }
    List<String?> values = [_fullname.text.trim(),_phone.text.trim(),_street.text.trim(),
    _city.text.trim(),_zipcode.text.trim(),email ,_doctorname, _date.toString()+ "  " + _appointtime.toString()];
    print(values);
    insertappointmentvalue(values,context);
  }

  }
