import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SelectChemist extends StatelessWidget {
  String cId, hname;
  SelectChemist.withId(String cemId, hqname) {
    this.cId = cemId;
    this.hname = hqname;
  }
  Future fetchChemist() async {
    String url = Global().baseAPIurl + "/chemist/";

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String cemId = cId;

    var response = await http.get(Uri.parse(url + cemId), headers: {
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
            appBar: AppBar(
                title: Text('Chemist Details'),
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
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(bottom: 135),
              child: FutureBuilder(
                future: fetchChemist(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    var chemistObj = snapshot.data;

                    children = <Widget>[
                      GestureDetector(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: <Widget>[
                                  ClipPath(
                                    clipper: WaveClipperOne(),
                                    child: Container(
                                        height: 120,
                                        color: Colors.lightBlue[100],
                                        child: ListTile(
                                          title: Text(chemistObj['name'],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(hname,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
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
                                          EdgeInsets.fromLTRB(0, 10, 130, 10),
                                      child: Text('Personal Informaition',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.person),
                                    title: Text(
                                        chemistObj['owner_name'] == null
                                            ? ''
                                            : chemistObj['owner_name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.location_city),
                                    title:
                                        Text(address(chemistObj['shop_addr']),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.phone_android),
                                    title: Text(
                                        chemistObj['mobile'] == null
                                            ? ''
                                            : chemistObj['mobile'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.email),
                                    title: Text(
                                        chemistObj['email'] == null
                                            ? ''
                                            : chemistObj['email'],
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
                                          EdgeInsets.fromLTRB(0, 10, 210, 20),
                                      child: Text('Shop Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.group),
                                    title: Text(
                                        chemistObj['firmconstitution'] == null
                                            ? ''
                                            : chemistObj['firmconstitution'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.privacy_tip),
                                    title: Text(
                                        chemistObj['druglicense'] == null
                                            ? ''
                                            : chemistObj['druglicense'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.label),
                                    title: Text(
                                        chemistObj['gst'] == null
                                            ? ''
                                            : chemistObj['gst'].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ];
                  } else {
                    children = <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
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
            ))));
  }
}
