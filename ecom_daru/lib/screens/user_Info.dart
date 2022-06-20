import 'package:ecom_daru/account/myAccount.dart';
import 'package:ecom_daru/account/myOrders.dart';
import 'package:ecom_daru/account/userdata.dart';
import 'package:ecom_daru/home/inner_screens/upload_brands.dart';
import 'package:ecom_daru/screens/cart.dart';
import 'package:ecom_daru/wishlist/wishList.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              UserData(),
              Divider(
                height: 25,
                thickness: 1,
                color: Colors.black,
              ),
              InkWell(
                splashColor: Theme.of(context).splashColor,
                child: ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(WishList.routeName),
                  leading: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  title: Text('WishList'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              InkWell(
                splashColor: Theme.of(context).splashColor,
                child: ListTile(
                  onTap: () => Navigator.of(context).pushNamed(Cart.routeName),
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              InkWell(
                splashColor: Theme.of(context).splashColor,
                child: ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(UploadBrands.routeName),
                  leading: Icon(Icons.upload),
                  title: Text('Upload New Brand'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              MyAccount(),
              MyOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
