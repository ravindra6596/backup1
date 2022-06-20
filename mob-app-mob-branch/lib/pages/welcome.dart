import 'dart:io';

import 'package:navodian_life_sciences/top.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String token = "";
  int empId = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    sleep(Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn(context);
    return Scaffold(
      body: Center(
          child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Container(
                  width: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "assets/3C141500CF04713842C96777FF_1588083891135_500X.webp"),
                      ])))),
    );
  }

  isLoggedIn(context) async {
    Map<String, dynamic> sessionObj = await Global().checkIfLoggedIn();
    if (sessionObj == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MyTabs()),
          (Route<dynamic> route) => false);
      token = sessionObj["token"];
      empId = sessionObj["empid"];
    }
  }
}
