import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'icons.dart';
import 'stockiest.dart';
import 'package:navodian_life_sciences/login.dart';

class AllStockiests extends StatelessWidget {
  String daId, dname;
  AllStockiests.withId(String distId, distname) {
    this.daId = distId;
    this.dname = distname;
  }

  String url = Global().baseAPIurl + "/stockiests/?headquarter=";

  Future<List<dynamic>> fetchStockiest() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String distId = daId;
    var result = await http.get(Uri.parse(url + distId), headers: {
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

  int sId(dynamic sid) {
    return sid['id'];
  }

  String _name(dynamic sname) {
    return sname['name'] == null ? 'No Name' : sname['name'];
  }

  String contact(dynamic scontact) {
    return scontact['shoptelephone'] == null
        ? 'No Phone'
        : scontact['shoptelephone'];
  }

  String address(dynamic saddress) {
    var addr = '';
    var addrObj =
        saddress['address'] == null ? '' : jsonDecode(saddress['address']);
    if (addrObj != null) {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Stockiests"),
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
          future: fetchStockiest(),
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
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: NameIcons()
                                  .getWidget(_name(snapshot.data[index])),
                              title: Text(
                                _name(snapshot.data[index]),
                              ),
                              subtitle: Text('\n' +
                                  address(snapshot.data[index]) +
                                  '\n' +
                                  dname),
                              trailing: Text(contact(snapshot.data[index])),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectStockiest.withId(
                                              sId(snapshot.data[index])
                                                  .toString(),
                                              dname)),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text("No stockiests present for this headquarter!!! "),
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
}
