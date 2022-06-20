import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

imageSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 2.0,
      enlargeCenterPage: true,
    ),
    items: [
      Image.asset('assets/images/rum.jpg'),
      Image.asset('assets/images/beer.jpg'),
      Image.asset('assets/images/wines.jpg'),
      Image.asset('assets/images/wine.jpeg'),
      Image.asset('assets/images/vodka.jpg'),
      Image.asset('assets/images/5.png'),
      Image.asset('assets/images/6.png'),
      Image.asset('assets/images/7.png'),
      Image.asset('assets/images/8.jpg'),
    ],
  );
}
