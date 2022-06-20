import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:navodian_life_sciences/login.dart';

class SelectDoctor extends StatelessWidget {
  String dId, tname;
  SelectDoctor.withId(String docId, String ter_name) {
    this.dId = docId;
    this.tname = ter_name;
  }

  Future fetchDoctor() async {
    String url = Global().baseAPIurl + "/doctor/";

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String docId = dId;

    var response = await http.get(Uri.parse(url + docId), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var data = json.decode(response.body)['data'];
    return data.isNotEmpty ? data : [];
  }

  String productName(dynamic pname) {
    return pname['productName'];
  }

  String address(dynamic daddress) {
    var addr = '';
    var addrObj = daddress == null ? '' : jsonDecode(daddress);
    if (addrObj != null) {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            //resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                title: Text('Doctor Details'),
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
            body: Center(
                child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: fetchDoctor(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                List<Widget> children;
                                if (snapshot.hasData) {
                                  var docObj = snapshot.data['doctor'];

                                  children = <Widget>[
                                    GestureDetector(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: <Widget>[
                                                ClipPath(
                                                  clipper: WaveClipperTwo(),
                                                  child: Container(
                                                      height: 120,
                                                      color:
                                                          Colors.lightBlue[100],
                                                      child: ListTile(
                                                        title: Text(
                                                            docObj['name'] ==
                                                                    null
                                                                ? ''
                                                                : 'Dr\t\t' +
                                                                    docObj[
                                                                        'name'],
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        subtitle: Text(tname,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 130, 10),
                                                    child: Text(
                                                        'Personal Informaition',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                ListTile(
                                                  dense: true,
                                                  leading:
                                                      Icon(Icons.location_city),
                                                  title: Text(
                                                      address(
                                                          docObj['address']),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading:
                                                      Icon(Icons.phone_android),
                                                  title: Text(
                                                      docObj['mobile'] == null
                                                          ? ''
                                                          : docObj['mobile'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.today),
                                                  title: Text(
                                                      docObj['dob'] == null
                                                          ? ''
                                                          : docObj['dob'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.school),
                                                  title: Text(
                                                      docObj['degree'] == null
                                                          ? ''
                                                          : docObj['degree'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.school),
                                                  title: Text(
                                                      docObj['speciality'] ==
                                                              null
                                                          ? ''
                                                          : docObj[
                                                              'speciality'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 210, 20),
                                                    child: Text(
                                                        'Clinic Details',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.call),
                                                  title: Text(
                                                      docObj['clinicphone'] ==
                                                              null
                                                          ? ''
                                                          : docObj[
                                                              'clinicphone'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.alarm),
                                                  title: Text('Morning Time ',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                  subtitle: Text(
                                                      docObj['mortimefrom'] ==
                                                                  null ||
                                                              docObj['mortimeto'] ==
                                                                  null
                                                          ? ''
                                                          : 'From:\t\t' +
                                                              docObj[
                                                                  'mortimefrom'] +
                                                              '\nTo:\t\t' +
                                                              docObj[
                                                                  'mortimeto'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey,
                                                      )),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  leading: Icon(Icons.alarm),
                                                  title: Text('Evening Time ',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                  subtitle: Text(
                                                      docObj['evetimefrom'] ==
                                                                  null ||
                                                              docObj['evetimeto'] ==
                                                                  null
                                                          ? ''
                                                          : 'From:\t\t' +
                                                              docObj[
                                                                  'evetimefrom'] +
                                                              '\nTo:\t\t' +
                                                              docObj[
                                                                  'evetimeto'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey,
                                                      )),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 170),
                                                  child: Text('Focused Product',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    )
                                  ];
                                } else {
                                  children = <Widget>[
                                    SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 60,
                                      height: 60,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Awaiting result...'),
                                    )
                                  ];
                                }

                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: children,
                                  ),
                                );
                              },
                            ),
                          ],
                        ))))));
  }
}
