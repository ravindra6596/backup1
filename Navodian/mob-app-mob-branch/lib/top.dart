import 'package:Navodian_Life_Sciences/pages/alldistricts.dart';
import 'package:Navodian_Life_Sciences/pages/allheadquarters.dart';
import 'package:Navodian_Life_Sciences/pages/allterritory.dart';
import 'package:Navodian_Life_Sciences/pages/sales.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'pages/holidays.dart';
import 'pages/leaves.dart';
import 'pages/profile.dart';
import 'pages/returns.dart';
import 'pages/allchemists.dart';
import 'pages/allstockiests.dart';
import 'pages/tourplan.dart';
import 'pages/homepage.dart';
import 'pages/allproducts.dart';
import 'pages/alldoctors.dart';
import 'pages/alluseractivity.dart';
import 'pages/addtarget.dart';
import 'pages/addsale.dart';

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;
  SharedPreferences sharedPreferences;
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    getUserInfo();
  }

  getUserInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    this.name = sharedPreferences.getString('name');
    this.email = sharedPreferences.getString('email');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Dashboard"),
        bottom: new TabBar(
          unselectedLabelColor: Colors.white70,
          controller: controller,
          dragStartBehavior: DragStartBehavior.start,
          tabs: <Tab>[
            new Tab(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              text: "Home",
            ),
            new Tab(
                icon: Icon(
                  Icons.directions_bike,
                  color: Colors.white,
                ),
                text: "TourPlan"),
            new Tab(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                text: "Products"),
          ],
        ),
        flexibleSpace: Container(),
      ),
      drawer: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.only(bottom: 10),
              children: <Widget>[
                Container(
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: new CircleAvatar(
                      radius: 70.0,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    accountName: new Text(
                      this.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    accountEmail: new Text(
                      this.email,
                      style: TextStyle(fontSize: 15),
                    ),
                    decoration: BoxDecoration(
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
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Profile",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.local_hospital,
                    color: Colors.black,
                  ),
                  title: Text("Doctors"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllTerritories()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.store_mall_directory,
                    color: Colors.black,
                  ),
                  title: Text("Chemists"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllHeadquarters()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.business,
                    color: Colors.black,
                  ),
                  title: Text("Stockiests"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllHeadquarters()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  title: Text("Holidays"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Holidays()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.directions_walk,
                    color: Colors.black,
                  ),
                  title: Text("My Activity"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllUserActivity()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.leave_bags_at_home,
                    color: Colors.black,
                  ),
                  title: Text("Leaves"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Leaves()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.attach_money,
                    color: Colors.black,
                  ),
                  title: Text("Target"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTarget()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  title: Text("Secondory Sale"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSale()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.autorenew,
                    color: Colors.black,
                  ),
                  title: Text("Returns"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Returns()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.bar_chart,
                    color: Colors.black,
                  ),
                  title: Text("Sales"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sale()),
                    );
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('token');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage()));
                  },
                  title: Text("Logout"),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          )),
      body: new TabBarView(
        controller: controller,
        children: [
          Home(),
          Tourplan(),
          Products(),
        ],
      ),
    );
  }
}
