import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import '../global.dart';
import '../login.dart';

class AddLeave extends StatefulWidget {
  Map leaveObj;
  AddLeave(this.leaveObj) {}

  @override
  _AddLeaveState createState() => _AddLeaveState(this.leaveObj);
}

class _AddLeaveState extends State<AddLeave> {
  bool _isLoading = false;
  String token = "";

  Map leaveObj;
  _AddLeaveState(this.leaveObj) {}

  @override
  Widget build(BuildContext context) {
    isLoggedIn();

    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('Apply Leave'),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF3366FF),
                    const Color(0xFF00CCFF),
                    Colors.blue,
                    Colors.teal
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0, 2.0, 3.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Column(
          children: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: DateTimeForm(this.leaveObj),
                  )
                ]),
    ));
  }

  isLoggedIn() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
    token = sessionObj["token"];
  }
}

class DateTimeForm extends StatefulWidget {
  Map leaveObj;
  DateTimeForm(this.leaveObj) {}

  @override
  _DateTimeFormState createState() => _DateTimeFormState(this.leaveObj);
}

class _DateTimeFormState extends State<DateTimeForm> {
  final TextEditingController leaveReason = new TextEditingController();

  Map leaveObj;
  String leaveType = "Personal";
  String leaveSession = "Full Day";
  bool _isLoading = false;
  DateTime dateF, dateT;

  _DateTimeFormState(this.leaveObj) {}

  final formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: dateF ?? DateTime.now(),
                    lastDate: DateTime(2030));
              },
              onChanged: (dt) {
                setState(() => dateF = dt);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'From Date',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: DateTimeField(
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2030));
                },
                onChanged: (dt) {
                  setState(() => dateT = dt);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'To Date',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text("Leave Type",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: leaveType,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              leaveType = newValue;
                            });
                          },
                          items: <String>['Sick Leave', 'Personal', 'Emergency']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text("Leave Session",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: leaveSession,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              leaveSession = newValue;
                            });
                          },
                          items: <String>[
                            'Full Day',
                            'First Half',
                            'Second Half'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )))),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              maxLines: 10,
              controller: leaveReason,
              maxLength: 1500,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Leave Reason',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(top: 15.0),
            child: RaisedButton(
              onPressed: () {
                _isLoading = true;
                if (!(leaveReason.text == "" ||
                    dateF == null ||
                    dateT == null)) {
                  submitLeave(
                      leaveReason.text, this.leaveType, this.leaveSession);
                } else {
                  showAlert("Must select dates and provide reason", "Error");
                }
              },
              color: Colors.blue,
              child: Text("Submit", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }

  submitLeave(String reason, type, session) async {
    Map data = {
      'reason': reason,
      'leave_type': type,
      'leave_session': session,
      'from_date': dateF.toString(),
      'to_date': dateT.toString(),
    };

    String body = json.encode(data);

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    String token = sessionObj["token"];

    var response = await http.post(
      Uri.parse(Global().baseAPIurl + "/leave/store"),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      showAlert("Leave applied Successfully.", "Success");
    } else {
      showAlert("Error while applying leave.", "Error");
    }
  }

  showAlert(msg, alertType) {
    Alert(
      context: context,
      type: alertType == "Success" ? AlertType.success : AlertType.error,
      title: alertType,
      desc: msg,
      buttons: alertType == "Success"
          ? [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.of(context).pop(),
                width: 120,
              )
            ]
          : [],
    ).show();
    setState(() {
      _isLoading = false;
    });
  }
}
