
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:sqliteapp/sqlite3/appointmentdatabase.dart';
import 'package:sqliteapp/sqlite3/database.dart';


final  _formKey = GlobalKey<FormState>();
String? _gendervalue;
List<String> gender = ['Male','Female','Others'];
var currentyear = new DateTime.now().year;
String? _appointtime;

TextEditingController _fullname = new TextEditingController();
TextEditingController _phone = new TextEditingController();
TextEditingController _street = new TextEditingController();
TextEditingController _city = new TextEditingController();
TextEditingController _zipcode = new TextEditingController();
TextEditingController _email = new TextEditingController();
TextEditingController _doctorname = new TextEditingController();

class Appointment extends StatefulWidget {
  @override
  AppointmentState createState() => AppointmentState();
}

class AppointmentState extends State<Appointment> {
  @override
  void initState() {
    createdatabase();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      elevation: 20.0,

        title: Text('Book an Appointment'),
      ),
      body: Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SingleChildScrollView(
        child: Card(
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(),
            borderRadius: BorderRadius.circular(2),
          ) ,
          shadowColor: Colors.blueAccent,
          borderOnForeground: true,
          child:  appointmentform(context)
        ),
      ),
      
      
      ),
    );
  }
}

void formvalidate(BuildContext context)
{
  if (_formKey.currentState!.validate())
  {
    if (_appointtime == null)
    {
      _appointtime = new DateTime.now().toString();
    }
    List<String?> values = [_email.text.trim(),_phone.text.trim(),_street.text.trim(),
    _city.text.trim(),_zipcode.text.trim(),_email.text.trim(),_doctorname.text.trim(),_appointtime.toString()];
    print(values);

  }
  else
  {
    print("not validate");
    List<String?> values = [_email.text.trim(),_phone.text.trim(),_street.text.trim(),
    _city.text.trim(),_zipcode.text.trim(),_email.text.trim(),_doctorname.text.trim(),_appointtime.toString()];
    print(values);
    insertappointmentvalue(values,context);
  }
}

Widget appointmentform(BuildContext context)
{
  return Form(
            key:  _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                
                children: <Widget>[
                  TextFormField(
                    maxLength: 100,
                    autovalidateMode: AutovalidateMode.always, 
                    controller: _fullname,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'Full Name',
      
                    ),
                    validator: (value)
                    {
                      if (value!.isEmpty)
                      {
                        return "Required";
                      }
                      else
                      {
                        return null;
                      }
      
                    } ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always, 
                    controller: _phone,
                    
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'Phone',
      
                    ),
                    validator: (value)
                    {
                      if (value!.isEmpty)
                      {
                        return "Required";
                      }
                      else
                      {
                        return null;
                      }
                    } ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always, 
                    controller: _street,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'Street Name',
      
                    ),
                    validator: (String? value)
                    {
                      if (value != null)
                      {
                        return "Required";
                      }
                    } ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.always, 
                                          controller: _city,
                        style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'City',
      
                    ),
                       validator: (value)
                                          {
                        if (value != null)
                        {
                          return "Required";
                        }
                            
                                          } ,
                                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                        
                                          controller: _zipcode,
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'ZipCode',
      
                    ),
                    validator: (value)
                                          {
                        if (value != null)
                        {
                          return "Required";
                        }
                            
                                          } ,
                                        ),
                      ),
                    ]),
                    
          TextFormField(
                    autovalidateMode: AutovalidateMode.always, 
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                   style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'Email',
      
                    ),

                  ),
                   SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always, 
                    controller: _doctorname,
                    keyboardType: TextInputType.emailAddress,
                   style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        gapPadding: 20,
                      ),
                      hintText: 'Doctor Name',
      
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Date and Time',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd-MMM-yyyy',
                    firstDate: DateTime(currentyear),
                    lastDate: DateTime(currentyear+10),
                    icon: Icon(Icons.date_range),
                    onSaved: (value)
                    {
                        _appointtime = value;
                    },
                    onChanged: (value)
                    {
                      _appointtime = value;
                      print(_appointtime);

                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () => formvalidate(context),
                     icon: Icon(Icons.login_sharp), 
                     label: Text('Submit'))
                  
                  
                ],
              
              ),
            ));
}