import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

class PendingTourplan extends StatefulWidget {
  @override
  _PendingTourplan createState() => _PendingTourplan();
}

class _PendingTourplan extends State<PendingTourplan> {
  String token = "";
  int empId = 0;

  Future<List<dynamic>> fetchTourplans() async {
    String url = Global().baseAPIurl + "/tourplan/pending/";

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];

    var result = await http.get(Uri.parse(url + empId.toString()), headers: {
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

    return [];
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

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Tourplan"),
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
          future: fetchTourplans(),
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
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: NameIcons()
                                .getWidget(dName(snapshot.data[index])),
                            title: Text(dName(snapshot.data[index])),
                            subtitle: Text(contact(snapshot.data[index]) +
                                '\n\n' +
                                address(snapshot.data[index])),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation(Colors.blue),
              ));
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
