import 'package:flutter/material.dart';
import '../global.dart';
import 'addleave.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Navodian_Life_Sciences/login.dart';

import 'homepage.dart';

class Leaves extends StatefulWidget {
  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  String token = "";
  int empId = 0;
  Future<List<dynamic>> fetchLeaves() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String url = Global().baseAPIurl + "/leaves/";
    var result = await http.get(url + empId.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(result.body);
    }
  }

  String date(dynamic user) {
    return user['created_at'];
  }

  String fromdate(dynamic user) {
    return user['fromdate'];
  }

  String todate(dynamic user) {
    return user['todate'];
  }

  String reaseon(dynamic user) {
    return user['comment'];
  }

  String type(dynamic user) {
    return user['leavetype'];
  }

  String status(dynamic user) {
    return user['status'];
  }

  @override
  Widget getWidget(String status) {
    if (status == 'Approved') {
      return Icon(Icons.check, color: Colors.green);
    } else if (status == 'Rejected') {
      return Icon(Icons.close, color: Colors.red);
    } else if (status == 'Pending') {
      return IconButton(
        icon: Icon(Icons.create),
        color: Colors.blue,
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLeave()),
          ); */
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("All Leaves"),
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
          future: fetchLeaves(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    date(snapshot.data[index]).toString(),
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          Container(
                              height: 80,
                              child: VerticalDivider(
                                color: Colors.grey,
                                width: 20,
                              )),
                          Container(
                              width: 160,
                              child: Text(
                                fromdate(snapshot.data[index]).toString() +
                                    '\t To\t' +
                                    todate(snapshot.data[index]).toString() +
                                    '\n\n' +
                                    type(snapshot.data[index]) +
                                    '\n\n' +
                                    reaseon(snapshot.data[index]),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              )),
                          Container(
                              height: 80,
                              child: VerticalDivider(
                                color: Colors.grey,
                                width: 40,
                              )),
                          Row(
                            children: <Widget>[
                              Container(
                                child: getWidget(status(snapshot.data[index])),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              /* return Center(
                child: Text("You dont have apply any leave to yet!!! "),
              ); */
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLeave()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
