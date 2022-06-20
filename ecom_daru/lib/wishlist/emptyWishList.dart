import 'package:ecom_daru/screens/feeds.dart';
import 'package:flutter/material.dart';

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/empty-wishlist.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'YOUR LIST IS EMPTY !',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
              letterSpacing: 1,
              height: .8,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Explore more and shortlist some items',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: .3,
              height: 1.5,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => Navigator.of(context).pushNamed(Feeds.routName),
            child: Text(
              'Add Favourites Items !',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
