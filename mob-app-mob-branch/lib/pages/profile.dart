import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;

import '../global.dart';
import '../login.dart';

class Profile extends StatelessWidget {
  Future<dynamic> getEmpProfile() async {
    BuildContext context;
    var ressss;

    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();

    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      ressss = getEmpData(context, sessionObj["token"], sessionObj["empid"]);
    }
    return ressss;
  }

  getEmpData(context, token, empid) async {
    var result = await http.get(
        Uri.parse(Global().baseAPIurl + "/user/" + empid.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(result.body)['data'];
    }
  }

  String address(dynamic address) {
    var addr = '';
    var addrObj = address == null ? '' : jsonDecode(address);
    if (addrObj != null) {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    //Get employee profile

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
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
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
          children: <Widget>[
            GestureDetector(
              child: FutureBuilder(
                  future: getEmpProfile(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new AssetImage(
                                                "assets/profile.png")))),
                                ClipPath(
                                  clipper: WaveClipperTwo(flip: true),
                                  child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      height: 110,
                                      width: 360,
                                      color: Colors.lightBlue[100],
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data['name'],
                                            textScaleFactor: 1.5,
                                          ),
                                          Text(snapshot.data['profile']
                                              ['designation'])
                                        ],
                                      )),
                                ),
                                ClipPath(
                                  clipper: WaveClipperTwo(reverse: true),
                                  child: Container(
                                    padding: EdgeInsets.only(top: 50),
                                    height: 340,
                                    color: Colors.blue,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                            Icons.phone_android,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                              snapshot.data['profile']['phone']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                            Icons.email,
                                            color: Colors.black,
                                          ),
                                          title: Text(snapshot.data['email'],
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                            Icons.today,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                              snapshot.data['profile']
                                                  ['birthdate'],
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                            Icons.location_city,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                              address(snapshot.data['profile']
                                                  ['permanentaddress']),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              )),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Icon(
                                            Icons.school,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                              snapshot.data['profile']
                                                  ['education'],
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ]);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
