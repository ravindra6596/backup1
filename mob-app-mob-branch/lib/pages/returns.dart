import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';
import '../login.dart';

class Returns extends StatefulWidget {
  @override
  _ReturnsState createState() => _ReturnsState();
}

class _ReturnsState extends State<Returns> {
  bool _isLoading = false;
  final datevalidator = GlobalKey<FormState>();
  String sid;
  String token = "";
  int empId = 0;

  List data = List();
  Map<int, List> values = {};
  final TextEditingController orderdate = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _dropdownError;
  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (sid == null) {
      setState(() => _dropdownError = "Select\nData!");
      _isValid = false;
    }

    if (_isValid) {
      //form is valid
    }
  }

  String surl = Global().baseAPIurl + "/stockiests";
  DateTime date2;
  Future fetchStockiest() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    var result = await http.get(Uri.parse(surl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonData = json.decode(result.body);

    if (result.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {}

    setState(() {
      data = jsonData;
    });
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    fetchStockiest();
  }

  String ordertype;

  String purl = Global().baseAPIurl + "/products";
  Future<List<dynamic>> fetchProducts() async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;

    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    var result = await http.get(Uri.parse(purl), headers: {
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

  String _name(dynamic pname) {
    return pname['pname'];
  }

  int pId(dynamic pid) {
    return pid['pid'];
  }

  double pts(dynamic pts) {
    return pts['pts'];
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      appBar: AppBar(
        title: Text("Returns"),
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
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: datevalidator,
                  child: DateTimeField(
                    validator: (DateTime dateTime) {
                      if (dateTime == null) {
                        return "Month Required";
                      }
                      return null;
                    },
                    onSaved: (DateTime dateTime) => date2 = dateTime,
                    //inputType: InputType.date,
                    //initialDate: DateTime.now(),
                    controller: orderdate,
                    keyboardType: TextInputType.datetime,
                    format: DateFormat("MM-yyyy"),
                    //editable: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Date',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => date2 = dt);
                    },
                  ))),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: Form(
                      key: _formKey,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        value: sid,
                        hint: Text("Select Stockiest",
                            style: TextStyle(color: Colors.black)),
                        items: data.map((list) {
                          return DropdownMenuItem(
                            child: Text(list['name']),
                            value: list['sid'].toString(),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            sid = value;
                            _dropdownError = null;
                          });
                        },
                      )))),
              Container(
                padding: EdgeInsets.only(left: 20),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    hint: Text("Type",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    value: ordertype,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    onChanged: (String newValue) {
                      setState(() {
                        ordertype = newValue;
                        _dropdownError = null;
                      });
                    },
                    items: <String>[
                      'Sale',
                      'Return',
                      'Expired',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))),
              _dropdownError == null
                  ? SizedBox.shrink()
                  : Text(
                      _dropdownError ?? "",
                      style: TextStyle(color: Colors.red, fontSize: 11),
                    ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Flexible(
              child: Container(
                  height: 380,
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchProducts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              List l = [
                                pId(snapshot.data[index]).toString(),
                                pts(snapshot.data[index]).toString(),
                                ""
                              ];
                              this.values.putIfAbsent(index, () => l);

                              return Card(
                                  elevation: 5,
                                  child: Row(children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      width: 180,
                                      child: Text(
                                        _name(snapshot.data[index]),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 70,
                                      child: TextField(
                                        onChanged: (String value) {
                                          this.values[index][1] = value;
                                        },
                                        // enabled: false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: pts(snapshot.data[index])
                                              .toString(),
                                          labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                    Container(height: 60, width: 10),
                                    Container(
                                      height: 50,
                                      width: 70,
                                      child: TextField(
                                        onChanged: (String value) {
                                          this.values[index][2] = value;

                                          if (this.values[index][2] == "") {}
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Quantity',
                                        ),
                                      ),
                                    ),
                                  ]));
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 300,
        height: 50,
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
            _isLoading = true;
            showAlert();
            _validateForm();
            submitData(this.values, orderdate.text);
          },
        ),
      ),
    );
  }

  void submitData(Map x, orderdate) async {
    var tot = 0.0;

    x.forEach((key, pro) {
      if (pro[1] != "" && pro[2] != "") {
        tot += double.parse(pro[1]) * int.parse(pro[2]);
      }
    });

    await submitOrder(orderdate, ordertype, int.parse(sid), tot, x);
  }

  submitOrder(String orderdate, ordertype, int sid, double totalAmt, x) async {
    Map data = {
      'orderdate': "01-" + orderdate,
      'total_amt': totalAmt,
      'eid': empId,
      'sid': sid,
      'type': ordertype
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(
      Uri.parse(Global().baseAPIurl + "/secsale/add"),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      showAlert();
      submitProduct(x, int.parse(response.body));
    } else {}
  }

  submitProduct(x, int orderid) async {
    List prods = [];

    x.forEach((key, pro) {
      if (pro[1] != "" && pro[2] != "") {
        var temp = {
          "pid": pro[0],
          "pts": pro[1],
          "quantity": pro[2],
          "orderid": orderid
        };
        prods.add(temp);
      }
    });
    String body = json.encode(prods);

    var response = await http.post(
      Uri.parse(Global().baseAPIurl + "/allproducts/add"),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
    } else {}
  }

  Container showAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your Sale Added Successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Returns()),
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
