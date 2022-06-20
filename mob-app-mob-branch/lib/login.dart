import 'dart:convert';
import 'package:navodian_life_sciences/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text('Navodian Life Science'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                  footerSection()
                ],
              ),
      ),
    );
  }

  signIn(String username, password) async {
    Map data = {'email': username, 'password': password};
    String body = json.encode(data);
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse(Global().baseAPIurl + "/login"),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      if (jsonData != null) {
        sharedPreferences.setString("token", jsonData['token']);
        sharedPreferences.setString("name", jsonData['name']);
        sharedPreferences.setString("email", jsonData['email']);
        sharedPreferences.setInt("userid", jsonData['userID']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MyTabs()),
            (Route<dynamic> route) => false);
      }
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Sorry",
        desc: "Invalid Email or Password.",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future getUserData(username, token) async {
    var empdata = await http.get(
      Uri.parse(Global().baseAPIurl + "/employee/username/" + username),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (empdata.statusCode == 200) {
      return json.decode(empdata.body);
    }
    return null;
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        color: Colors.blue,
        child: Text("Sign In", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.black),
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: _obscureText,
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                suffixIcon: InkWell(
                  onTap: _toggle,
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 25.0,
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      child: Column(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              // margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.only(bottom: 50),
              height: 200,
              width: 360,
              color: Colors.teal[100],
              child: Image.asset(
                  "assets/3C141500CF04713842C96777FF_1588083891135_500X.webp"),
            ),
          )
        ],
      ),
    );
  }

  Container footerSection() {
    return Container(
        child: Column(children: [
      ClipPath(
          clipper: WaveClipperOne(reverse: true),
          child: Container(
            height: 139,
            width: 360,
            color: Colors.lightBlue,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 130,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/light-1.png"))),
                  ),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/light-2.png"))),
                  ),
                ),
              ],
            ),
          ))
    ]));
  }
}
