import 'package:ecom_daru/products/cart_Attribute.dart';
import 'package:ecom_daru/products/favourite_Attributes.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  Map<String, FavouriteAttributes> favouriteItems = {};
  Map<String, FavouriteAttributes> get getfavouriteItems {
    return {...favouriteItems};
  }

  void addRemoveFavourite(
    String productId,
    double price,
    String title,
    String image,
    String productCattitle,
  ) {
    //check brand id is avail to cart or not
    if (favouriteItems.containsKey(productId)) {
      removeFavouriteItem(productId);
    } else {
      favouriteItems.putIfAbsent(
        productId,
        () => FavouriteAttributes(
          id: DateTime.now().toString(),
          title: title,
          productCattitle: productCattitle,
          image: image,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

// remove item from list of card
  void removeFavouriteItem(String productId) {
    favouriteItems.remove(productId);
    notifyListeners();
  }

//clear all items form cart
  void clearFavourite() {
    favouriteItems.clear();
    notifyListeners();
  }
}
