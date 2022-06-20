import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Navodian_Life_Sciences/login.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';

class UserActivity {
  int aid;
  String latitude;
  String longitude;
  String ptype;
  DateTime visit;

  UserActivity({this.latitude, this.longitude, this.ptype, this.visit});

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
        latitude: json['latitude'],
        longitude: json['longitude'],
        ptype: json['place_type'],
        visit: json['created_at']);
  }
}

class AllUserActivity extends StatefulWidget {
  @override
  _AllUserActivityState createState() => _AllUserActivityState();
}

class _AllUserActivityState extends State<AllUserActivity> {
  String token = "";
  int empId = 0;
  DateTime fdate;
  DateTime tdate;
  String strDate;
  Future<void> fromDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fdate ?? now,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != fdate) {
      print('From Date $picked');
      setState(() {
        fdate = picked;
      });
    }
  }

  Future<void> toDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tdate ?? now,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != tdate) {
      print('To Date $picked');
      setState(() {
        tdate = picked;
      });
    }
  }

  dateFilter() {
    Alert(
        context: context,
        title: "Select Dates",
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: fromdate,
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                await fromDate(context);
                fromdate.text = DateFormat('dd-MM-yyyy').format(fdate);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'From Date',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 12.0,
                ),
              ),
              validator: (String value) {
                print('date:: ${fdate.toString()}');
                if (value.isEmpty) {
                  return 'From Date is Required.';
                }
                return null;
              },
              onSaved: (String val) {
                strDate = val;
              },
            ),
            Container(
              height: 50,
            ),
            TextFormField(
              controller: todate,
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                await toDate(context);
                todate.text = DateFormat('dd-MM-yyyy').format(tdate);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'To Date',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 12.0,
                ),
              ),
              validator: (String value) {
                print('date:: ${tdate.toString()}');
                if (value.isEmpty) {
                  return 'To Date is Required.';
                }
                return null;
              },
              onSaved: (String val) {
                strDate = val;
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            height: 50,
            width: 150,
            onPressed: fromdate.text == "" || todate.text == ""
                ? null
                : () {
                    _isLoading = true;
                    // Tourplan.withDate(fromdate.text, todate.text);
                  },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  DateTime date2;
  final TextEditingController fromdate = new TextEditingController();
  final TextEditingController todate = new TextEditingController();
  bool _isLoading = false;
  Future<List<dynamic>> fetchActivity() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String url = Global().baseAPIurl + "/user/activities/";
    var response = await http.get(url + empId.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(response.body);
    }
  }

  String feedback(dynamic uactivityfeedback) {
    return uactivityfeedback['feedback'];
  }

  String lat(dynamic uactivitylatitude) {
    return uactivitylatitude['latitude'].toString();
  }

  String long(dynamic uactivitylongitude) {
    return uactivitylongitude['longitude'].toString();
  }

  String ptype(dynamic uactivityptype) {
    return uactivityptype['place_type'];
  }

  String visit(dynamic uactivityvisit) {
    return uactivityvisit['created_at'];
  }

  @override
  Widget getWidget(String ptype) {
    if (ptype == 'Doctor') {
      return Icon(
        Icons.local_hospital,
        color: Colors.black,
      );
    } else if (ptype == 'Chemist') {
      return Icon(
        Icons.store_mall_directory,
        color: Colors.black,
      );
    } else if (ptype == 'Stockiest') {
      return Icon(
        Icons.business,
        color: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
        appBar: AppBar(
          title: Text("All Activity"),
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
        ),
        body: Container(
          child: FutureBuilder<List<dynamic>>(
            //  future: AllUseractivityModel().fetchUsers(),
            future: fetchActivity(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: Border(
                            right: BorderSide(
                          color: Colors.lightBlue,
                          width: 10,
                        )),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: getWidget(ptype(snapshot.data[index])),
                              title: Text(lat(snapshot.data[index]).toString() +
                                  '\t\t' +
                                  long(snapshot.data[index]).toString()),
                              subtitle: Text('\n\nVisited At:' +
                                  visit(snapshot.data[index]) +
                                  '\n' +
                                  feedback(snapshot.data[index])),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                /*  return Center(
                  child: Text("You dont have any activity to yet!!! "),
                );
                  */
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: Icon(Icons.filter_alt),
                  onPressed: () {
                    dateFilter();
                  }),
            )));
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
