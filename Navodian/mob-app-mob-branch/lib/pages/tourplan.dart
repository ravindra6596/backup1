import 'package:Navodian_Life_Sciences/global.dart';
import 'package:Navodian_Life_Sciences/pages/pendingtourplan.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'adddoctortourplan.dart';
import 'package:flutter/material.dart';
import 'icons.dart';
import 'report.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Navodian_Life_Sciences/login.dart';

class Tourplan extends StatefulWidget {
  @override
  _TourplanState createState() => _TourplanState();

  static withId(String string, String name) {}
}

class _TourplanState extends State<Tourplan> {
  String fromD;
  String toD;
  String token = "";
  int empId = 0;

  Future<List<dynamic>> fetchTourplans() async {
    String url;
    print(fromD);
    print('okkkkk');
    print(this.fromD);
    if (fromD == "" || toD == "" || fromD == null || toD == null) {
      url = Global().baseAPIurl + "/tourplan/";
      //print(url);
    } else {
      url = Global().baseAPIurl + "/tourplandate/" + "/" + fromD + "/" + toD;
      print(url);
    }

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];

    var result = await http.get(url + empId.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(result.body);
    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(result.body);
    }
  }

  int dId(dynamic tpaln) {
    return tpaln['doctorId'];
  }

  String dName(dynamic tpaln) {
    return tpaln['doctorName'];
  }

  String contact(dynamic tpaln) {
    return tpaln['doctorClinicphone'];
  }

  String speciality(dynamic tpaln) {
    return tpaln['doctorSpeciality'];
  }

  String lat(dynamic tpaln) {
    return tpaln['doctorLatitude'].toString();
  }

  String long(dynamic tpaln) {
    return tpaln['doctorLongitude'].toString();
  }

  String address(dynamic tpaln) {
    return tpaln['doctorAddress'];
  }

  DateTime fdate;
  DateTime tdate;
  String strDate;
  final TextEditingController fromdate = new TextEditingController();
  final TextEditingController todate = new TextEditingController();

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
                this.fromD = fromdate.text;
                print(fdate);
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
                // this.toD;
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
            /*  onPressed: fromdate.text == "" || todate.text == ""
                ? null
                : () {
                    _isLoading = true;
                    print('ok');
                  }, */
            onPressed: () {
              print('ok');
              print(this.fromD);
              fetchTourplans();
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchTourplans(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: NameIcons()
                                .getWidget(dName(snapshot.data[index])),
                            title: Text(dName(snapshot.data[index])),
                            subtitle: Text(contact(snapshot.data[index]) +
                                '\n\n' +
                                address(snapshot.data[index])),
                            trailing: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Report.withData(
                                              dId(snapshot.data[index])
                                                  .toString(),
                                              dName(snapshot.data[index]),
                                              lat(snapshot.data[index])
                                                  .toString(),
                                              long(snapshot.data[index])
                                                  .toString(),
                                              address(snapshot.data[index]),
                                            ),
                                          ));
                                    },
                                    child: const Text('Mark Visit',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        )),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              /* return Center(
                child: Text("You dont have tourplan for yet!!! "),
              ); */
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation(Colors.blue),
              ));
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        //child: Icon(Icons.add),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.filter_alt,
              ),
              label: 'Find Tourplan',
              onTap: () {
                dateFilter();
              }),
          SpeedDialChild(
              child: Icon(Icons.local_hospital),
              label: 'Add Doctor TourPlan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorTourPlan()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.pending_actions),
              label: 'Pending TourPlan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingTourplan()),
                );
              }),
        ],
      ),
    );
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
