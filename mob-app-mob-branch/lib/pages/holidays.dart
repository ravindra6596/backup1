import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../login.dart';

class Holidays extends StatefulWidget {
  @override
  _HolidaysState createState() => _HolidaysState();
}

class _HolidaysState extends State<Holidays> {
  final String url = Global().baseAPIurl + "/holidays";

  Future<List<dynamic>> fetchHolidays() async {
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
    }

    var data = json.decode(result.body)['data'];
    return data.isNotEmpty ? data : [];
  }

  final TextEditingController fromdate = new TextEditingController();
  final TextEditingController todate = new TextEditingController();

  List results = [];
  DataRow _getDataRow(index, data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(data["holiday_date"])),
        DataCell(Text(data["description"])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('All Holidays'),
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
                  //future: AllChemistsModel().fetchUsers(),
                  future: fetchHolidays(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      results = snapshot.data;
                      return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue[200]),
                            columnSpacing: 30,
                            columns: [
                              DataColumn(label: Text('Sr')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Title')),
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
        ));
  }
}
