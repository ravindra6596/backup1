import 'dart:ui';

import 'package:Navodian_Life_Sciences/global.dart';

import 'product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Navodian_Life_Sciences/login.dart';

class Products extends StatelessWidget {
  String token = "";
  int empId = 0;
  final String url = Global().baseAPIurl + "/products";
  Future<List<dynamic>> fetchProducts() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];

    var result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      //print(result.body);
      return json.decode(result.body);
    }
  }

  String _name(dynamic pname) {
    return pname['pname'];
  }

  int pId(dynamic pid) {
    return pid['pid'];
  }

  String specification(dynamic pspecification) {
    return pspecification['ptype'];
  }

  String prod_pic(dynamic pro_pic) {
    return pro_pic['filename'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.3,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          // future: AllDoctorsModel().fetchUsers(),
          future: fetchProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(prod_pic(snapshot.data[1]));

                    return Card(
                        shape: Border(
                            right: BorderSide(
                          color: Colors.lightBlue,
                          width: 5,
                        )),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectProduct.withId(
                                        pId(snapshot.data[index]).toString())),
                              );
                            },
                            child: Column(children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  /*   //trailing: Image.network("http://50708849fccc.ngrok.io/images/${snapshot[index][filename]}"),
                        trailing: Image.network(
                            "https://7c6255079f41.ngrok.io/navodian-life-sciences/images/Screenshot%20(51).png"
                            /* prod_pic(snapshot.data[index]) */),
 */
                                  child: Image.asset(
                                    'assets/cream.jpeg',
                                    height: 100,
                                    width: 250,
                                  )),
                              Divider(thickness: 2),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      _name(snapshot.data[index]),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, top: 5),
                                child: Row(
                                  children: [
                                    Text(specification(snapshot.data[index]),
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ])));
                  });
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
