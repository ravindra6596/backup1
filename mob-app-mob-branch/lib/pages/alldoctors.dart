import 'package:flutter/material.dart';
import '../global.dart';
import 'doctor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

import 'icons.dart';

class AllDoctors extends StatelessWidget {
  String taId, tname;
  AllDoctors.withId(String terId, String ter_name) {
    this.taId = terId;
    this.tname = ter_name;
  }
  String token = "";
  int empId = 0;
  String url = Global().baseAPIurl + "/doctors/?territory=";
  Future<List<dynamic>> fetchDoctors() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String terID = this.taId;
    var result = await http.get(Uri.parse(url + terID), headers: {
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

  String _name(dynamic dname) {
    return dname['name'] == null ? '' : dname['name'];
  }

  int dId(dynamic docid) {
    return docid['id'];
  }

  String contact(dynamic dcontact) {
    return dcontact['clinicphone'] == null ? '' : dcontact['clinicphone'];
  }

  String speciality(dynamic dspeciality) {
    return dspeciality['speciality'] == null ? '' : dspeciality['speciality'];
  }

  String address(dynamic daddress) {
    var addr = '';
    var addrObj =
        daddress['address'] == null ? '' : jsonDecode(daddress['address']);
    if (addrObj != null) {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  _launchURL() async {
    const url = 'https://www.google.co.in/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("All Doctors"),
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
          future: fetchDoctors(),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
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
                                    builder: (context) => SelectDoctor.withId(
                                        dId(snapshot.data[index]).toString(),
                                        tname)),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: NameIcons()
                                      .getWidget(_name(snapshot.data[index])),
                                  isThreeLine: true,
                                  title: Text(
                                    _name(snapshot.data[index]),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text('\n' +
                                                contact(snapshot.data[index]) +
                                                '\n' +
                                                address(snapshot.data[index]) +
                                                '\n' +
                                                this.tname),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    speciality(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 2),
                                      width: 160,
                                      child: RaisedButton.icon(
                                          shape: new RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.blue,
                                              ),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0)),
                                          color: Colors.white,
                                          onPressed: () => launch(
                                              'tel:${contact(snapshot.data[index])}'),
                                          icon: Icon(Icons.call),
                                          label: Text('Call')),
                                    ),
                                    Container(
                                      width: 161,
                                      margin: EdgeInsets.only(left: 2),
                                      child: RaisedButton.icon(
                                          shape: new RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.blue,
                                              ),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0)),
                                          color: Colors.white,
                                          onPressed: _launchURL,
                                          icon: Icon(Icons.location_on),
                                          label: Text('Directions')),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      );
                    });
              } else {
                return Center(
                  child: Text("No doctors present"),
                );
              }
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
