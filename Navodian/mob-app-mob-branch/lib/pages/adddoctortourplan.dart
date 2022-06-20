import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../global.dart';
import '../login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DoctorTourPlan extends StatefulWidget {
  @override
  _DoctorTourPlanState createState() => _DoctorTourPlanState();
}

class _DoctorTourPlanState extends State<DoctorTourPlan> {
  Map<int, Map> values = {};
  DateTime date2;
  String token = "";
  int empId = 0;
  bool _isLoading = false;
  final datevalidator = GlobalKey<FormState>();

  final TextEditingController tourplandate = new TextEditingController();

  final String url = Global().baseAPIurl + "/doctors/";
  Future<List<dynamic>> fetchDoctors() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];

    var result = await http.get(url + empId.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      return json.decode(result.body);
    }
  }

  String dname(dynamic drplan) {
    return drplan['name'];
  }

  int dID(dynamic did) {
    return did['doctorid'];
  }

  String address(dynamic tpaln) {
    return tpaln['address'];
  }

  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor TourPlan"),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.teal,
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0, 2.0, 3.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Form(
                key: datevalidator,
                child: DateTimePickerFormField(
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Date Required";
                    }
                    return null;
                  },
                  onSaved: (DateTime dateTime) => date2 = dateTime,
                  inputType: InputType.date,
                  initialDate: DateTime.now(),
                  controller: tourplandate,
                  keyboardType: TextInputType.datetime,
                  format: DateFormat("dd-MM-yyyy"),
                  editable: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Date',
                      hasFloatingPlaceholder: true),
                  onChanged: (dt) {
                    setState(() => date2 = dt);
                  },
                ))),
        Flexible(
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: fetchDoctors(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        //  print(index);
                        Map l = {
                          "dID": dID(snapshot.data[index]),
                          "checked": false,
                        };

                        this.values.putIfAbsent(index, () => l);

                        return Card(
                          elevation: 5,
                          /*  shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ), */
                          shape: Border(
                              right: BorderSide(
                            color: Colors.lightBlue,
                            width: 10,
                          )),
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                title: Text(
                                  dname(snapshot.data[index]),
                                ),
                                subtitle: Text(address(snapshot.data[index])),
                                value: this.values[index]["checked"],
                                onChanged: (newValue) {
                                  setState(() {
                                    values[index]["checked"] = newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
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
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 300,
        height: 40,
        child: RaisedButton(
            color: Colors.blue,
            shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 2),
                borderRadius: new BorderRadius.circular(5.0)),
            child: Text("Submit"),
            onPressed: () {
              if (datevalidator.currentState.validate()) {
                datevalidator.currentState.save();
              }
              showAlert();
              submitData(this.values, tourplandate.text);
            }),
      ),
    );
  }

  submitData(
    Map x,
    String date,
  ) async {
    var docid = [];
    values.forEach((index, value) {
      if (value["checked"] == true) {
        docid.add({
          'doctorid': value["dID"],
          'date': date,
          'eid': empId,
        });
      }
    });

    String body = json.encode(docid);
    // print(body);
    var jsonData;

    var response = await http.post(
      Global().baseAPIurl + "/alltourplan/add",
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      showAlert();

      if (jsonData != null) {}
    } else {}
  }

  Container showAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your Tourplan Added Successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => DoctorTourPlan()),
              (Route<dynamic> route) => false),
          width: 120,
        )
      ],
    ).show();
    setState(() {
      _isLoading = false;
    });
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
