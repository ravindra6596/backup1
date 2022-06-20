import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

import '../global.dart';

class SelectProduct extends StatelessWidget {
  String pId;
  SelectProduct.withId(String proId) {
    this.pId = proId;
  }
  Future fetchProduct() async {
    String url = Global().baseAPIurl + "/product/";

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String proId = pId;

    var result = await http.get(Uri.parse(url + proId), headers: {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Product Details'),
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
              padding: EdgeInsets.only(bottom: 135),
              child: FutureBuilder(
                future: fetchProduct(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      var prodObj = snapshot.data;
                      children = <Widget>[
                        GestureDetector(
                          child: InkWell(
                              onTap: () {}, // needed
                              child: Ink(
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
                                              color: Colors.lightBlue[100],
                                              child: ListTile(
                                                title: Text(
                                                    prodObj['name'] == null
                                                        ? ''
                                                        : prodObj['name'],
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    prodObj['type'] != null
                                                        ? prodObj['type']
                                                        : '',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                    )),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('Product Information',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        ListTile(
                                          dense: true,
                                          leading: Text('MRP:',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          title: Text(
                                              prodObj['mrp'] != null
                                                  ? prodObj['mrp'].toString()
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Text('PTR:',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          title: Text(
                                              prodObj['ptr'] != null
                                                  ? prodObj['ptr'].toString()
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Text('PTS:',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          title: Text(
                                              prodObj['pts'] != null
                                                  ? prodObj['pts'].toString()
                                                  : '',
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
                                        Text('Product Details',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(Icons.assignment),
                                          title: Text(
                                              prodObj['detailing_story'] != null
                                                  ? prodObj['detailing_story']
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                              Icons.notification_important),
                                          title: Text(
                                              prodObj['dose'] != null
                                                  ? prodObj['dose']
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                            height: 200,
                                            width: 350,
                                            color: Colors.blueGrey,
                                            child: Image.network(
                                                prodObj['filename'])),
                                      ],
                                    ),
                                  ]))),
                        )
                      ];
                    } else {
                      children = <Widget>[
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Oops! Something went wrong..',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              subtitle:
                                  Text('Error Code:' + snapshot.data.statusCode,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
            )))));
  }
}
/**/
