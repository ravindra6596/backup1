import 'package:navodian_life_sciences/pages/allchemists.dart';
import 'package:navodian_life_sciences/pages/allstockiests.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

import 'icons.dart';

class AllHeadquarters extends StatefulWidget {
  String type;

  AllHeadquarters.withType(String type) {
    this.type = type;
  }

  @override
  _AllHeadquartersState createState() => _AllHeadquartersState();
}

class _AllHeadquartersState extends State<AllHeadquarters> {
  String token = "";
  int empId = 0;
  String url = Global().baseAPIurl + "/user/";
  Future<List<dynamic>> fetchHeadquarters() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    var result = await http
        .get(Uri.parse(url + empId.toString() + '/headquarters'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var data = json.decode(result.body)['data'];
    return data.isNotEmpty ? data : [];
  }

  String _name(dynamic hname) {
    return hname['name'];
  }

  int haId(dynamic hid) {
    return hid['id'];
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("All HeadQuarters"),
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
          future: fetchHeadquarters(),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data);
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
                            if (widget.type == 'stockiest') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllStockiests.withId(
                                        haId(snapshot.data[index]).toString(),
                                        _name(snapshot.data[index]))),
                              );
                            }
                            if (widget.type == 'chemist') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllChemists.withId(
                                        haId(snapshot.data[index]).toString(),
                                        _name(snapshot.data[index]))),
                              );
                            }
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
