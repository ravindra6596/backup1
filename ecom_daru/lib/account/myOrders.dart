import 'dart:ui';

import 'package:flutter/material.dart';

import 'dottedline.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 50,
            width: double.infinity,
            color: Colors.grey[100],
            child: Text(
              'My Orders',
              style: TextStyle(
                // color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          myOrdersList(),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          TextButton(
            onPressed: () {},
            child: Text('More Orders'),
          ),
          Divider(
            thickness: 10,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10.0),
                  height: 50.0,
                  child: Text(
                    'LOGOUT',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16.0),
                  ),
                ),
                Spacer(),
                Icon(Icons.power_settings_new),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 20.0),
            height: 130.0,
            color: Colors.grey[200],
            child: Text(
              'App Version v3.1.0',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey[700], fontSize: 13.0),
            ),
          )
        ],
      ),
    );
  }

  Container myOrdersList() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Imperial Blue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Maharaja Wine',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rs112',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                'Delivered',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(2.2),
                  color: Colors.green,
                  child: Icon(Icons.check, color: Colors.white, size: 14.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          DottedSeperatorView(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.5, color: Colors.orange),
                ),
                onPressed: () {},
                child: Text(
                  'REORDER',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.5, color: Colors.green),
                ),
                onPressed: () {},
                child: Text(
                  'RATE BRAND',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
