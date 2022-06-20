import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_daru/home/categories/categories.dart';
import 'package:ecom_daru/home/header/headerContent.dart';
import 'package:ecom_daru/home/homeappbar.dart';
import 'package:ecom_daru/home/imageSlider.dart';
import 'package:ecom_daru/home/inner_screens/brands_navigation_rail.dart';
import 'package:ecom_daru/home/popularBrands.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:ecom_daru/widgets/Tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _brandImages = [
    // 'assets/images/1.png',
    'assets/images/2.jpg',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final popularProductsData = Provider.of<Products>(context);
    final populerProducts = popularProductsData.populerProduct;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                homeAppBar(context),
                HeaderContent(),
                imageSlider(),
                Divider(
                  height: 30,
                  thickness: 10,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        ' Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            BrandNavigationRailScreen.routeName,
                            arguments: {
                              index,
                            },
                          );
                        },
                        child: Categories(
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 30,
                  thickness: 10,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Top Brands',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            TabBarTest.routeName,
                            arguments: {
                              7,
                            },
                          );
                        },
                        child: Text(
                          'View all...',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Swiper(
                    itemCount: _brandImages.length,
                    autoplay: true,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    onTap: (index) {
                      Navigator.of(context).pushNamed(
                        TabBarTest.routeName,
                        arguments: {
                          index,
                        },
                      );
                    },
                    itemBuilder: (BuildContext ctx, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.blueGrey,
                          child: Image.asset(
                            _brandImages[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 10,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Popular Brands',
                    style: TextStyle(
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 285,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: populerProducts.length,
                      itemBuilder: (context, int index) {
                        return ChangeNotifierProvider.value(
                          value: populerProducts[index],
                          child: PopularBrands(
                              // desc: populerProducts[index].desc,
                              // title: populerProducts[index].title,
                              // image: populerProducts[index].image,
                              // price: populerProducts[index].price,
                              ),
                        );
                      }),
                ),
                // TopsPiked(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/* Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            index,
                          },
                        );
                      },
                      child: Categories(
                        index: index,
                      ),
                    );
                  },
                ),
              ), */