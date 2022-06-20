import 'package:navodian_life_sciences/global.dart';
import 'package:navodian_life_sciences/pages/pendingtourplan.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'adddoctortourplan.dart';
import 'package:flutter/material.dart';
import 'icons.dart';
import 'report.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

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

    if (fromD == "" || toD == "" || fromD == null || toD == null) {
      url = Global().baseAPIurl + "/tour-plan/";
    } else {
      url = Global().baseAPIurl + "/tour-plan/" + "/" + fromD + "/" + toD;
    }

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];

    var result = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else if (result.statusCode == 200) {
      var data = json.decode(result.body)['data'];
      return data.isNotEmpty ? data : [];
    }
    return [];
  }

  int tpId(dynamic tplan) {
    return tplan['id'];
  }

  int entityId(dynamic tplan) {
    return tplan['entity_id'];
  }

  String entityType(dynamic tplan) {
    return tplan['entity_type'];
  }

  String entityName(dynamic tplan) {
    return tplan['details'] == null || tplan['details']['name'] == null
        ? ''
        : tplan['details']['name'];
  }

  String contact(dynamic tpaln) {
    return '111111';
  }

  String speciality(dynamic tpaln) {
    return 'aaaaaaaaaaaaa';
  }

  String lat(dynamic tpaln) {
    return '123222';
  }

  String long(dynamic tpaln) {
    return '1233333';
  }

  String address(dynamic tplan) {
    var addr = '';

    if (tplan['details'] == null) return addr;

    var addrObj =
        tplan['details']['address'] == null ? '' : tplan['details']['address'];

    if (addrObj != null && addrObj != '') {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  int approval(dynamic tplan) {
    return tplan['approval'];
  }

  DateTime fdate;
  DateTime tdate;
  String strDate;
  int planApproval;
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
            onPressed: () {
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
              if (snapshot.data.length > 0) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      this.planApproval = approval(snapshot.data[index]);
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: NameIcons()
                                  .getWidget(entityName(snapshot.data[index])),
                              title: Text(entityName(snapshot.data[index])),
                              subtitle: Text(contact(snapshot.data[index]) +
                                  '\n\n' +
                                  address(snapshot.data[index])),
                              trailing: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    approval(snapshot.data[index]) == null
                                        ? Text('Approval \n Pending')
                                        : (approval(snapshot.data[index]) == 1
                                            ? RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Report.withData(
                                                          tpId(snapshot
                                                                  .data[index])
                                                              .toString(),
                                                          entityType(snapshot
                                                                  .data[index])
                                                              .toString(),
                                                          entityId(snapshot
                                                                  .data[index])
                                                              .toString(),
                                                          entityName(snapshot
                                                              .data[index]),
                                                          lat(snapshot
                                                                  .data[index])
                                                              .toString(),
                                                          long(snapshot
                                                                  .data[index])
                                                              .toString(),
                                                          address(snapshot
                                                              .data[index]),
                                                        ),
                                                      ));
                                                },
                                                child: Text('Mark Visit',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    )),
                                              )
                                            : Text('Plan \n Rejected')),
                                  ]),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text("You dont have any tourplan yet!!!"),
                );
              }
            } else {
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
