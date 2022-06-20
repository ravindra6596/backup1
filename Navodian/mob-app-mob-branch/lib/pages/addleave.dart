import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:Navodian_Life_Sciences/pages/leaves.dart';
import 'package:intl/intl.dart';

import '../global.dart';
import '../login.dart';

class AddLeave extends StatefulWidget {
  @override
  _AddLeaveState createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  bool _isLoading = false;
  String token = "";
  int empId = 0;

  String type;
  DateTime date2;

  Container showAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your Leave Added Successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Leaves()),
              (Route<dynamic> route) => false),
          width: 120,
        )
      ],
    ).show();
    setState(() {
      _isLoading = false;
    });
  }

  submitLeave(String reason, type, fromdate, todate) async {
    Map data = {
      'comment': reason,
      'leavetype': type,
      'fromdate': fromdate,
      'todate': todate,
      'eid': empId,
    };
    print(empId);
    String body = json.encode(data);

    var response = await http.post(
      Global().baseAPIurl + "/leave/add",
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      showAlert();
    } else {}
  }

  final TextEditingController leaveReason = new TextEditingController();
  final TextEditingController fromdate = new TextEditingController();
  final TextEditingController todate = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    isLoggedIn();

    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('Add Leaves'),
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
                  child: DateTimePickerFormField(
                    inputType: InputType.date,
                    controller: fromdate,
                    format: DateFormat("dd-MM-yyyy"),
                    initialDate: DateTime.now(),
                    keyboardType: TextInputType.datetime,
                    editable: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'From Date',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    onChanged: (dt) {
                      setState(() => date2 = dt);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: DateTimePickerFormField(
                    controller: todate,
                    inputType: InputType.date,
                    format: DateFormat("dd-MM-yyyy"),
                    initialDate: DateTime.now(),
                    keyboardType: TextInputType.datetime,
                    editable: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'To Date',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => date2 = dt);
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 30),
                      child: Text("Select Leave",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          hint: Text("Leave Type",
                              style: TextStyle(color: Colors.black)),
                          value: type,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              type = newValue;
                            });
                          },
                          items: <String>['Sick Leave', 'Personal', 'Emergency']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ))),
                  ],
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
                    onPressed: leaveReason.text == "" ||
                            fromdate.text == "" ||
                            todate.text == ""
                        ? null
                        : () {
                            _isLoading = true;
                            submitLeave(leaveReason.text, type, fromdate.text,
                                todate.text);
                          },
                    color: Colors.blue,
                    child:
                        Text("Submit", style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )
              ],
      ),
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
    empId = sessionObj["empid"];
  }
}
