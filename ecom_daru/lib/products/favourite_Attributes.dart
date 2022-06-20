import 'package:flutter/material.dart';

class FavouriteAttributes with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String productCattitle;
  final double price;

  FavouriteAttributes({
    required this.id,
    required this.title,
    required this.productCattitle,
    required this.image,
    required this.price,
  });
}
