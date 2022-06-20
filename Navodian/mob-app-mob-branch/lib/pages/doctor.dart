import 'package:Navodian_Life_Sciences/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Navodian_Life_Sciences/login.dart';

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

    var response = await http.get(url + docId, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return response;
    }
  }

  Future<List<dynamic>> focusedProduct() async {
    String url = Global().baseAPIurl + "/focusedproduct/";

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String docId = dId;
    var response = await http.get(url + docId, headers: {
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

  String productName(dynamic pname) {
    return pname['productName'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
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
                                  if (snapshot.data.statusCode == 200) {
                                    var docObj =
                                        json.decode(snapshot.data.body);

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
                                                        color: Colors
                                                            .lightBlue[100],
                                                        child: ListTile(
                                                          title: Text(
                                                              'Dr\t\t' +
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
                                                                color: Colors
                                                                    .black,
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
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(
                                                        Icons.location_city),
                                                    title: Text(
                                                        docObj['address'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(
                                                        Icons.phone_android),
                                                    title: Text(
                                                        docObj['mobile'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(Icons.today),
                                                    title: Text(docObj['dob'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(Icons.school),
                                                    title: Text(
                                                        docObj['degree'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(Icons.school),
                                                    title: Text(
                                                        docObj['speciality'],
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
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Icon(Icons.call),
                                                    title: Text(
                                                        docObj['clinicphone'],
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
                                                        'From:\t\t' +
                                                            docObj[
                                                                'mortimefrom'] +
                                                            '\nTo:\t\t' +
                                                            docObj['mortimeto'],
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
                                                        'From:\t\t' +
                                                            docObj[
                                                                'evetimefrom'] +
                                                            '\nTo:\t\t' +
                                                            docObj['evetimeto'],
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
                                                      child: Text(
                                                          'Focused Product',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ],
                                              ),
                                            ]),
                                      )
                                    ];
                                  } else {
                                    children = <Widget>[
                                      Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                                'Oops! Something went wrong..',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Text(
                                                'Error Code:' +
                                                    snapshot.data.statusCode,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                )),
                                          )
                                        ],
                                      ),
                                    ];
                                  }
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
                            FutureBuilder<List<dynamic>>(
                              //  future:ScopedModel.of(fetchUsers()),
                              future: focusedProduct(),

                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(8),
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(productName(
                                                snapshot.data[index])));
                                      });
                                }
                              },
                            ),
                          ],
                        ))))));
  }
}
