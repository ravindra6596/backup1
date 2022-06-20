import 'package:Navodian_Life_Sciences/pages/alldoctors.dart';
import 'package:Navodian_Life_Sciences/pages/tourplan.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'doctor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Navodian_Life_Sciences/login.dart';

import 'icons.dart';

class AllTerritories extends StatefulWidget {
  @override
  _AllTerritoriesState createState() => _AllTerritoriesState();
}

class _AllTerritoriesState extends State<AllTerritories> {
  String token = "";
  int empId = 0;
  String url = Global().baseAPIurl + "/territory/";

  Future<List<dynamic>> fetchTerritories() async {
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

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(result.body);
    }
  }

  String _name(dynamic tname) {
    return tname['territory'];
  }

  int taId(dynamic docid) {
    return docid['taid'];
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("All Territories"),
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
          //  future:ScopedModel.of(fetchUsers()),
          future: fetchTerritories(),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //  print(snapshot.data);
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
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllDoctors.withId(
                                      taId(snapshot.data[index]).toString(),
                                      _name(snapshot.data[index]))),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tourplan.withId(
                                      taId(snapshot.data[index]).toString(),
                                      _name(snapshot.data[index]))),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: NameIcons()
                                    .getWidget(_name(snapshot.data[index])),
                                title: Text(
                                  _name(snapshot.data[index]),
                                ),
                              ),
                            ],
                          )),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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
