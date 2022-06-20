import 'package:navodian_life_sciences/global.dart';
import 'package:flutter/material.dart';
import 'chemist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:navodian_life_sciences/login.dart';
import 'icons.dart';

class AllChemists extends StatelessWidget {
  String haId, hname;
  AllChemists.withId(String headId, String hqname) {
    this.haId = headId;
    this.hname = hqname;
  }
  String name;
  String url = Global().baseAPIurl + "/chemists/?headquarter=";
  Future<List<dynamic>> fetchChemists() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String headId = haId;
    var result = await http.get(Uri.parse(url + headId), headers: {
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

  int cId(dynamic chemid) {
    return chemid['id'];
  }

  String _name(dynamic cname) {
    return cname['name'] == null ? 'No Name' : cname['name'];
  }

  String contact(dynamic ccontact) {
    return ccontact['mobile'] == null ? 'No Phone' : ccontact['mobile'];
  }

  String address(dynamic caddress) {
    var addr = '';
    var addrObj =
        caddress['shop_addr'] == null ? '' : jsonDecode(caddress['shop_addr']);
    if (addrObj != null) {
      addrObj.forEach((k, v) => addr += v != null ? v + " \n" : "");
    }
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Chemists"),
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
          //future: AllChemistsModel().fetchUsers(),
          future: fetchChemists(),
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
                                  hname),
                              trailing: Text(contact(snapshot.data[index])),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectChemist.withId(
                                              cId(snapshot.data[index])
                                                  .toString(),
                                              hname)),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text("No chemists present for this territory!!! "),
                );
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(
                      //valueColor: new AlwaysStoppedAnimation(Colors.blue),
                      ));
            }
          },
        ),
      ),
    );
  }
}
