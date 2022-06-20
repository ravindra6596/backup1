import 'package:ecom_daru/products/cart_Attribute.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttribute> cartItems = {};
  Map<String, CartAttribute> get getCartItems {
    return {...cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addBrandToCart(
    String brandId,
    double price,
    String title,
    String image,
    String productCattitle,
  ) {
    //check brand id is avail to cart or not
    if (cartItems.containsKey(brandId)) {
      cartItems.update(
        brandId,
        (existingCartItems) => CartAttribute(
          id: existingCartItems.id,
          title: existingCartItems.title,
          productCattitle: existingCartItems.productCattitle,
          image: existingCartItems.image,
          price: existingCartItems.price,
          quantity: existingCartItems.quantity + 1,
        ),
      );
    } else {
      cartItems.putIfAbsent(
        brandId,
        () => CartAttribute(
          id: DateTime.now().toString(),
          title: title,
          productCattitle: productCattitle,
          image: image,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

//remove one item form cart like -1 
  void removeCartItemByOne(
    String brandId,
   
  ) {
    if (cartItems.containsKey(brandId)) {
      cartItems.update(
        brandId,
        (existingCartItems) => CartAttribute(
          id: existingCartItems.id,
          title: existingCartItems.title,
          productCattitle: existingCartItems.productCattitle,
          image: existingCartItems.image,
          price: existingCartItems.price,
          quantity: existingCartItems.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }
// remove item from list of card
  void removeItem(String productId) {
    cartItems.remove(productId);
    notifyListeners();
  }

//clear all items form cart
  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
