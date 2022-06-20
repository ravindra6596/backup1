import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';

class SelectStockiest extends StatelessWidget {
  String sId, dname;
  SelectStockiest.withId(String stoId, distname) {
    this.sId = stoId;
    this.dname = distname;
  }

  Future fetchStockiest() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String url = Global().baseAPIurl + "/stockiest/";
    String stoId = sId;

    var response = await http.get(Uri.parse(url + stoId), headers: {
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
            //resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                title: Text('Stockiest Details'),
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
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: FutureBuilder(
                future: fetchStockiest(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    var stockiestObj = snapshot.data;
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
                                          title: Text(
                                              stockiestObj['name'] == null
                                                  ? ''
                                                  : stockiestObj['name'],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(dname,
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
                                        stockiestObj['owner_name'] == null
                                            ? ''
                                            : stockiestObj['owner_name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.location_city),
                                    title:
                                        Text(address(stockiestObj['address']),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.phone_android),
                                    title: Text(
                                        stockiestObj['mobile'] == null
                                            ? ''
                                            : stockiestObj['mobile'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.email),
                                    title: Text(
                                        stockiestObj['email'] == null
                                            ? ''
                                            : stockiestObj['email'],
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
                                    leading: Icon(Icons.call),
                                    title: Text(
                                        stockiestObj['shoptelephone'] == null
                                            ? ''
                                            : stockiestObj['shoptelephone'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.group),
                                    title: Text(
                                        stockiestObj['firmconstitution'] == null
                                            ? ''
                                            : stockiestObj['firmconstitution'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.privacy_tip),
                                    title: Text(
                                        stockiestObj['druglicense'] == null
                                            ? ''
                                            : stockiestObj['druglicense'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(Icons.label),
                                    title: Text(
                                        stockiestObj['gst'] == null
                                            ? ''
                                            : stockiestObj['gst'].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Divider(
                                    color: Colors.grey,
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
