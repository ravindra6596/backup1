import 'package:Navodian_Life_Sciences/pages/alluseractivity.dart';
import 'package:Navodian_Life_Sciences/pages/doctor.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';
import '../login.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
  String dId, name, add, lat, long;
  Report.withData(String docId, String docname, String latitude,
      String longitude, String address) {
    this.dId = docId;
    this.name = docname;
    this.add = address;
    this.lat = latitude;
    this.long = longitude;
  }
}

class _ReportState extends State<Report> {
  bool _isLoading = false;
  bool _isLocationServiceEnabled = false;
  String token = "";
  int empID = 0;
  var _formKey = GlobalKey<FormState>();
  List data = List();
  Map<int, Map> values = {};

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

  int pID(dynamic pid) {
    return pid['pid'];
  }

  Container submit_tourplan() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your TourPlan Added Successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => AllUserActivity()),
              (Route<dynamic> route) => false),
          width: 120,
        )
      ],
    ).show();
    setState(() {
      _isLoading = false;
    });
  }

  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  final TextEditingController feedbackController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    isLoggedIn();

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: Text('Report Details'),
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
            body: ListTile(
              title: Container(
                  child: ListTile(
                      title: Text('Dr\t\t' + widget.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              subtitle: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              //   onChanged: _handleRadioValueChange,
                              onChanged: (int visited) {
                                setState(() {
                                  _radioValue = visited;
                                });
                              },
                            ),
                            new Text(
                              'Visited',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              // onChanged: _handleRadioValueChange,
                              onChanged: (int value) {
                                setState(() {
                                  _radioValue = value;
                                });
                              },
                            ),
                            new Text(
                              'Not Visited',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 200,
                          child: FutureBuilder<List<dynamic>>(
                            future: fetchProducts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                //print(snapshot.data);
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(8),
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //  print(index);
                                      Map l = {
                                        "pID": pID(snapshot.data[index]),
                                        "checked": false,
                                      };

                                      this.values.putIfAbsent(index, () => l);

                                      return Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        margin: EdgeInsets.all(0.5),
                                        shape: Border(
                                            right: BorderSide(
                                          color: Colors.lightBlue,
                                          width: 10,
                                        )),
                                        child: Column(
                                          children: <Widget>[
                                            CheckboxListTile(
                                              title: Text(
                                                _name(snapshot.data[index]),
                                              ),
                                              value: this.values[index]
                                                  ["checked"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  values[index]["checked"] =
                                                      newValue;
                                                });
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading, //  <-- leading Checkbox
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return Center(
                                    child: CircularProgressIndicator(
                                        //valueColor: new AlwaysStoppedAnimation(Colors.blue),
                                        ));
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            maxLines: 5,
                            controller: feedbackController,
                            maxLength: 1500,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Visit Details',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(top: 15.0),
                          child: RaisedButton(
                            onPressed: feedbackController.text == ""
                                ? null
                                : () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    submitFeedback(feedbackController.text,
                                        _radioValue.toString());
                                    submitFocusedProduct(this.values);
                                  },
                            color: Colors.blue,
                            child: Text("Submit",
                                style: TextStyle(color: Colors.white)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )
                      ],
                    ),
            )));
  }

  getCurrentLocation() async {
    _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (_isLocationServiceEnabled) {}
  }

  submitFeedback(String feedback, String status) async {
    if (_radioValue == 0) {
      status = 'Visited';
      print(status);
    } else {
      status = 'Not Visited';
      print(status);
    }
    Map data = {
      'feedback': feedback,
      'place_type': 'Doctor',
      'place_id': widget.dId,
      'eid': empID,
      'longitude': widget.lat,
      'latitude': widget.long,
      'status': status
    };

    String body = json.encode(data);
    print(body);
    var response = await http.post(
      Global().baseAPIurl + "/user/activity/store",
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      submit_tourplan();
      return response.body;
    }
  }

  submitFocusedProduct(
    Map x,
  ) async {
    var docid = [];
    values.forEach((index, value) {
      if (value["checked"] == true) {
        docid.add({
          'pid': value["pID"],
          'doctorid': widget.dId,
        });
      }
    });

    String body = json.encode(docid);
    print(body);
    var jsonData;

    var response = await http.post(
      Global().baseAPIurl + "/focusedproduct/add",
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      if (jsonData != null) {}
    } else {}
  }

  isLoggedIn() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      token = sessionObj["token"];
      empID = sessionObj["empid"];
    }
  }
}
