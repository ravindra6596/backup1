import 'package:badges/badges.dart';
import 'package:ecom_daru/products/feedBrands.dart';
import 'package:ecom_daru/products/product.dart';
import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:ecom_daru/wishlist/wishList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class Feeds extends StatelessWidget {
  static const routName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    List<Product> productsList = productProvider.product;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).cardColor ,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Feeds',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Consumer<FavouriteProvider>(
            builder: (_, fav, ch) => Badge(
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(
                top: 5,
                end: 7,
              ),
              badgeContent: Text(
                fav.getfavouriteItems.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(WishList.routeName),
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              badgeColor: Colors.black,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(
                top: 5,
                end: 7,
              ),
              badgeContent: Text(
                cart.getCartItems.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Cart.routeName),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(productsList.length, (index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: FeedBrands(),
          );
        }),
      ),
    );
  }
}
