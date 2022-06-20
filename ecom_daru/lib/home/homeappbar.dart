import 'package:ecom_daru/home/location.dart';
import 'package:ecom_daru/home/map.dart';
import 'package:flutter/material.dart';

homeAppBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(
      left: 5,
      right: 5,
    ),
    child: Row(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayMap(),
            ),
          ),
          child: Icon(Icons.location_on),
        ),
        Location(),
        Spacer(),
        Icon(
          Icons.local_offer,
        ),
        TextButton(
          onPressed: () {
           
          },
          child: Text(
            'Offers',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}
