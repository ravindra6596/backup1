import 'package:flutter/material.dart';

class CartAttribute with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String productCattitle;
  final double price;
  final int quantity;

  CartAttribute({
    required this.id,
    required this.title,
    required this.productCattitle,
    required this.image,
    required this.price,
    required this.quantity,
  });
}
