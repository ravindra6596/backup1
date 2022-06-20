import 'package:ecom_daru/home/inner_screens/categories_feeds.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> categoryList = [
    {
      'name': 'Wine',
      'brandImage': 'assets/images/wine.jpeg',
    },
    {
      'name': 'Vodka',
      'brandImage': 'assets/images/vodka.jpg',
    },
    {
      'name': 'Beer',
      'brandImage': 'assets/images/beer.jpg',
    },
    {
      'name': 'Rum',
      'brandImage': 'assets/images/rum.jpg',
    },
    {
      'name': 'Whiskey',
      'brandImage': 'assets/images/wines.jpg',
    },
    {
      'name': 'Brandy',
      'brandImage': 'assets/images/6.png',
    },
    {
      'name': 'Cognac',
      'brandImage': 'assets/images/8.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                CategorisFeeds.routName,
                arguments: '${categoryList[widget.index]['name']}',
              );
            },
            child: Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    categoryList[widget.index]['brandImage'],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              child: Text(
                categoryList[widget.index]['name'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
