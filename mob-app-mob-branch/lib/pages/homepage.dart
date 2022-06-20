import 'dart:convert';
import 'package:navodian_life_sciences/pages/sales.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'package:flutter/material.dart';
import '../login.dart';

class Home extends StatefulWidget {
  @override
  final Widget child;

  Home({Key key, this.child}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    Future<Map<String, dynamic>> x = Global().checkIfLoggedIn();
    x.then((value) {
      if (value == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }
  String token = "";
  int empId = 0;

  Future<List<dynamic>> todayTourplan() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    String url = Global().baseAPIurl + "/todaytour/";
    var result = await http.get(Uri.parse(url + empId.toString()), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return [];
    }
  }

  String tourid(dynamic user) {
    return "Tour Id: " + user['tourid'].toString();
  }

  String dId(dynamic docid) {
    return "Doctor Id:" + docid['doctor_id'].toString();
  }

  String dName(dynamic docname) {
    return docname['doctorName'];
  }

  String dAddress(dynamic docadd) {
    return docadd['doctorAddress'];
  }

  String dContact(dynamic doccontact) {
    return doccontact['doctorClinicphone'];
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Sale(),
            ),
          ),

          /* Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
            color: Colors.red,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width * 0.9,
            child: BezierChart(
              bezierChartScale: BezierChartScale.CUSTOM,
              xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
              series: const [
                BezierLine(
                  data: const [
                    DataPoint<double>(value: 10, xAxis: 0),
                    DataPoint<double>(value: 130, xAxis: 5),
                    DataPoint<double>(value: 50, xAxis: 10),
                    DataPoint<double>(value: 150, xAxis: 15),
                    DataPoint<double>(value: 75, xAxis: 20),
                    DataPoint<double>(value: 0, xAxis: 25),
                    DataPoint<double>(value: 5, xAxis: 30),
                    DataPoint<double>(value: 45, xAxis: 35),
                  ],
                ),
              ],
              config: BezierChartConfig(
                verticalIndicatorStrokeWidth: 3.0,
                verticalIndicatorColor: Colors.black26,
                showVerticalIndicator: true,
                backgroundColor: Colors.blue,
                snap: false,
              ),
            ),
          ), */
          Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          Text(
            "Today`s TourPlan",
            style: new TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          /* Flexible(
              child:  */
          /*  Divider(
            color: Colors.grey,
            thickness: 2,
          ), */
          Container(
            height: 300,
            child: FutureBuilder<List<dynamic>>(
              future: todayTourplan(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(dName(snapshot.data[index])),
                                  subtitle: Text(
                                      '\n' + dAddress(snapshot.data[index])),
                                  trailing:
                                      Text(dContact(snapshot.data[index])),
                                ),
                                Container(),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text("You dont have tourplan for today!!! "),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            //)
          ),
          Container()
        ],
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
