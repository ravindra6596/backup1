import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../global.dart';
import '../login.dart';

class AddTarget extends StatefulWidget {
  @override
  _AddTargetState createState() => _AddTargetState();

  DateTime date;
}

class _AddTargetState extends State<AddTarget> {
  DateTime fdate;
  DateTime tdate;
  String strDate;
  String fromD;
  String toD;
  String token = "";
  int empId = 0;
  Future<void> fromDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fdate ?? now,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != fdate) {
      print('From Date $picked');
      setState(() {
        fdate = picked;
      });
    }
  }

  Future<void> toDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tdate ?? now,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != tdate) {
      print('To Date $picked');
      setState(() {
        tdate = picked;
      });
    }
  }

  dateFilter() {
    Alert(
        context: context,
        title: "Select Dates",
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: fromdate,
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                await fromDate(context);
                fromdate.text = DateFormat('dd-MM-yyyy').format(fdate);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'From Date',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 12.0,
                ),
              ),
              validator: (String value) {
                print('date:: ${fdate.toString()}');
                if (value.isEmpty) {
                  return 'From Date is Required.';
                }
                return null;
              },
              onSaved: (String val) {
                strDate = val;
              },
            ),
            Container(
              height: 50,
            ),
            TextFormField(
              controller: todate,
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                await toDate(context);
                todate.text = DateFormat('dd-MM-yyyy').format(tdate);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'To Date',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 12.0,
                ),
              ),
              validator: (String value) {
                print('date:: ${tdate.toString()}');
                if (value.isEmpty) {
                  return 'To Date is Required.';
                }
                return null;
              },
              onSaved: (String val) {
                strDate = val;
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            height: 50,
            width: 150,
            onPressed: fromdate.text == "" || todate.text == ""
                ? null
                : () {
                    _isLoading = true;
                  },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  final TextEditingController fromdate = new TextEditingController();
  final TextEditingController todate = new TextEditingController();
  bool _isLoading = false;

  Future<List<dynamic>> fetchTargets() async {
    String url;

    if (fromD == "" || toD == "" || fromD == null || toD == null) {
      url = Global().baseAPIurl + "/targets/";
      print(url);
    } else {
      url = Global().baseAPIurl + "/target/" + "/" + fromD + "/" + toD;
      print(url);
    }
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    BuildContext context;
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    var token = sessionObj["token"];
    var result = await http.get(Uri.parse(url + empId.toString()), headers: {
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

  List results = [];
  DataRow _getDataRow(index, data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(data["month"])),
        DataCell(Text(data["amount"].toString())),
        DataCell(Text(data["headquarter"])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Targets'),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: FutureBuilder<List<dynamic>>(
                  future: fetchTargets(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      results = snapshot.data;

                      return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: DataTable(
                            columnSpacing: 20,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue[200]),
                            columns: [
                              DataColumn(label: Text('Sr')),
                              DataColumn(label: Text('Month')),
                              DataColumn(label: Text('Amount(₹)')),
                              DataColumn(label: Text('Territory')),
                            ],
                            rows: List.generate(results.length,
                                (index) => _getDataRow(index, results[index])),
                            showBottomBorder: true,
                          ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: Icon(Icons.filter_alt),
                  onPressed: () {
                    dateFilter();
                  }),
            )));
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
