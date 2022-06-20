import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class StockiestTourPlan extends StatefulWidget {
  @override
  _StockiestTourPlanState createState() => _StockiestTourPlanState();
}

class _StockiestTourPlanState extends State<StockiestTourPlan> {
  final String url =
      "http://healthcareapi-env.eba-83fpcz2g.ap-south-1.elasticbeanstalk.com/stockiests";
  DateTime date2;
  Future<List<dynamic>> fetchUsers() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    return json.decode(result.body);
  }

  String pname(dynamic tpaln) {
    return tpaln['pname'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stockiest TourPlan"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("dd-MM-yyyy"),
                  initialDate: DateTime.now(),
                  keyboardType: TextInputType.datetime,
                  editable: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Date',
                      hasFloatingPlaceholder: true),
                  onChanged: (dt) {
                    setState(() => date2 = dt);
                  },
                )),
            Column(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('Damini '),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 100,
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('ABC'),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 100,
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('Ravindra'),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 100,
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('Bill Gates'),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                height: 50, width: 100, child: Icon(Icons.add))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('Manoj'),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                height: 50, width: 100, child: Icon(Icons.add))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          height: 60,
                          width: 200,
                          child: Text('Damini'),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                height: 50, width: 100, child: Icon(Icons.add))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ))
          ],
        )));
  }
}
