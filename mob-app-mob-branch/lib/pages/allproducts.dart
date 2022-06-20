import 'dart:ui';

import 'package:navodian_life_sciences/global.dart';

import 'product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:navodian_life_sciences/login.dart';

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

    var result = await http.get(Uri.parse(url), headers: {
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

  String _name(dynamic pname) {
    return pname['name'] == null ? '' : pname['name'];
  }

  int pId(dynamic pid) {
    return pid['id'];
  }

  String specification(dynamic pspecification) {
    return pspecification['type'] == null ? pspecification['type'] : '';
  }

  String proPic(dynamic proPic) {
    var filename = proPic['filename'];
    return filename;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
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
              if (snapshot.data.length > 0) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shape: Border(
                              right: BorderSide(
                            color: Colors.lightBlue,
                            width: 2,
                          )),
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectProduct.withId(
                                        pId(snapshot.data[index]).toString())),
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _name(snapshot.data[index]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                CachedNetworkImage(
                                  imageUrl: proPic(snapshot.data[index]),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  width: 200,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                // Image.network(
                                //   proPic(snapshot.data[index]),
                                //   loadingBuilder: (context, child, progress) {
                                //     return progress == null
                                //         ? child
                                //         : LinearProgressIndicator();
                                //   },
                                //   width: 200,
                                //   height: 100,
                                //   fit: BoxFit.fill,
                                //   semanticLabel: _name(snapshot.data[index]),
                                // )
                              ],
                            ),
                            // child: Column(
                            //   children: <Widget>[
                            //     ListTile(
                            //       title: Text(
                            //         _name(snapshot.data[index]),
                            //       ),
                            //       subtitle: Column(
                            //         children: [
                            //           Flexible(
                            //             flex: 2,
                            //             child: Image.network(
                            //               proPic(snapshot.data[index]),
                            //               loadingBuilder:
                            //                   (context, child, progress) {
                            //                 return progress == null
                            //                     ? child
                            //                     : LinearProgressIndicator();
                            //               },
                            //               width: 400,
                            //               height: 200,
                            //               fit: BoxFit.fill,
                            //               semanticLabel:
                            //                   _name(snapshot.data[index]),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // )),
                          ));
                    });
              } else {
                return Center(
                  child: Text("No products present"),
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
