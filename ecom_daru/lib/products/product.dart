import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String desc;
  final double price;
  final String image;
  final String productCattitle;
  final String brand;
  final bool isFavorite;
  final bool isPopuler;

  Product({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.productCattitle,
    required this.brand,
    required this.isFavorite,
    required this.isPopuler,
  });
 /*  List<Product> product = [
    Product(
      id: 1,
      image: 'assets/images/1.png',
      title: 'Sula Wine',
      desc: 'Continental North Indian, South Indian',
      price: 'Rs 200',
      brand: 'Wine',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 2,
      image: 'assets/images/2.jpg',
      title: 'Maharaja Beer Shop',
      desc: 'South Indian',
      price: 'Rs 2400',
      brand: 'Wine',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 3,
      image: 'assets/images/3.png',
      title: 'Hotel Nisarg',
      desc: 'South Indian',
      price: 'Rs 520',
      brand: 'Wine',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 4,
      image: 'assets/images/4.png',
      title: 'Dinner Expresss',
      desc: 'North Indian',
      price: 'Rs 200',
      brand: 'Rum',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 5,
      image: 'assets/images/5.png',
      title: 'Parota King',
      desc: 'South Indian',
      price: 'Rs 200',
      brand: 'Beer',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 6,
      image: 'assets/images/6.png',
      title: 'Mass Hotel',
      desc: 'South Indian',
      price: 'Rs 200',
      brand: 'Vodka',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 7,
      image: 'assets/images/7.png',
      title: 'Mumbai Bar',
      desc: 'South Indian',
      price: 'Rs 200',
      brand: 'Wine',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 8,
      image: 'assets/images/8.jpg',
      title: 'BBQ Nation',
      desc: 'South Indian',
      price: 'Rs 200',
      brand: 'Wine',
      productCattitle: '4.1 45 mins ',
      isFavorite: false,
      isPopuler: false,
    ),
  ];
 */}
