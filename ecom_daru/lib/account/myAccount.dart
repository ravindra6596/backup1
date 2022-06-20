import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  /* final List<String> titles = [
    'My Account',
    'SUPER Expired',
    'Swiggy Money',
    'Help',
  ];
  final List<String> body = [
    'Address, Payments, Favourties, Referrals & Offers',
    'You had a great savings run. Get SUPER again',
    'Balance & Transactions',
    'FAQ & Links',
  ];

   MyAccount({
    Key? key,
    required this.title,
    required this.body1,
    this.isLastItem = false,
  })  : assert(title != '', body1 != ''),
        super(key: key);

  final String title;
  final String body1;
  final bool isLastItem; */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Address, Payment, Favourties, Referrals & Offers',
                    ),
                  ],
                ),
              ),
              // Spacer(),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 1,
            // color: Colors.black,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUPER Expired',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'You had a great savings run. Get SUPER again',
                    ),
                  ],
                ),
              ),
              // Spacer(),
             InkWell(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 1,
            // color: Colors.black,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Swiggy Money',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Balance & Transactions',
                    ),
                  ],
                ),
              ),
              // Spacer(),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 1,
            // color: Colors.black,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'FAQ & Links',
                    ),
                  ],
                ),
              ),
              // Spacer(),
              InkWell(
                onTap: (){},
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            ],
          ),Divider(
                height: 25,
                thickness: 1,
                // color: Colors.black,
              ),
        ],
      ),
    );
  }
}
