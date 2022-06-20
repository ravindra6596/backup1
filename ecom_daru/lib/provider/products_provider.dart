import 'package:ecom_daru/products/product.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {
  List<Product> product = [
    Product(
      id: 1,
      image: 'assets/images/wines.jpg',
      title: 'Sula Wine',
      desc: 'Wine is an alcoholic drink typically made from fermented grapes. ',
      price: 450,
      brand: 'Wine',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 2,
      image: 'assets/images/wine.jpeg',
      title: 'Myra',
      desc: 'Wine is an alcoholic drink typically made from fermented grapes.',
      price: 2400,
      brand: 'Wine',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 3,
      image: 'assets/images/wine3.jpg',
      title: 'Big Banyan	',
      desc: 'Wine is an alcoholic drink typically made from fermented grapes.',
      price: 520,
      brand: 'Wine',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 4,
      image: 'assets/images/7.png',
      title: 'Seagrams Nine Hills	',
      desc: 'Wine is an alcoholic drink typically made from fermented grapes.',
      price: 1200,
      brand: 'Wine',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 5,
      image: 'assets/images/8.jpg',
      title: 'BBQ Nation',
      desc: 'Wine is an alcoholic drink typically made from fermented grapes.',
      price: 300,
      brand: 'Wine',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 6,
      image: 'assets/images/rum.jpg',
      title: 'Old Munk',
      desc:
          'Rum is a liquor made by fermenting then distilling sugarcane molasses or sugarcane juice. ',
      price: 342,
      brand: 'Rum',
      productCattitle: 'Alcoholic beverage',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 7,
      image: 'assets/images/rum1.jpg',
      title: 'Bacardi',
      desc:
          'Rum is a liquor made by fermenting then distilling sugarcane molasses or sugarcane juice. ',
      price: 490,
      brand: 'Rum',
      productCattitle: 'Alcoholic beverage',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 8,
      image: 'assets/images/rum2.jpg',
      title: 'Black',
      desc:
          'Rum is a liquor made by fermenting then distilling sugarcane molasses or sugarcane juice. ',
      price: 2890,
      brand: 'Rum',
      productCattitle: 'Alcoholic beverage',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 9,
      image: 'assets/images/rum3.jpg',
      title: 'McDowell\'s',
      desc:
          'Rum is a liquor made by fermenting then distilling sugarcane molasses or sugarcane juice. ',
      price: 890,
      brand: 'Rum',
      productCattitle: 'Alcoholic beverage',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 10,
      image: 'assets/images/vodka1.jpg',
      title: 'Absolute Vodka',
      desc: 'Vodka is a clear distilled alcoholic beverage.',
      price: 1600,
      brand: 'Vodka',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 11,
      image: 'assets/images/vodka3.png',
      title: 'Sky Vodka',
      desc: 'Vodka is a clear distilled alcoholic beverage.',
      price: 400,
      brand: 'Vodka',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 12,
      image: 'assets/images/vodka2.jpg',
      title: 'Magic Moments',
      desc: 'Vodka is a clear distilled alcoholic beverage.',
      price: 500,
      brand: 'Vodka',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 13,
      image: 'assets/images/beer4.jpg',
      title: ' Heineken',
      desc:
          'Beer is one of the oldest and most widely consumed alcoholic drinks',
      price: 330,
      brand: 'Beer',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 14,
      image: 'assets/images/beer3.jpg',
      title: 'Budweiser',
      desc:
          'Beer is one of the oldest and most widely consumed alcoholic drinks',
      price: 2500,
      brand: 'Beer',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 15,
      image: 'assets/images/beer2.jpeg',
      title: 'Tuborg',
      desc:
          'Beer is one of the oldest and most widely consumed alcoholic drinks',
      price: 230,
      brand: 'Beer',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 16,
      image: 'assets/images/beer1.jpg',
      title: 'Kingfisher',
      desc:
          'Beer is one of the oldest and most widely consumed alcoholic drinks',
      price: 300,
      brand: 'Beer',
      productCattitle: 'Alcoholic drink',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 17,
      image: 'assets/images/hennessy.jpg',
      title: 'Hennessy ',
      desc: 'Cognac is a type of brandy',
      price: 670,
      brand: 'Cognac',
      productCattitle: 'Distilled spirit type',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 18,
      image: 'assets/images/remy.jpg',
      title: 'Rémy Martin XO',
      desc: 'Cognac is a type of brandy',
      price: 230,
      brand: 'Cognac',
      productCattitle: 'Distilled spirit type',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 19,
      image: 'assets/images/hine.png',
      title: 'Hine Antique XO',
      desc: 'Cognac is a type of brandy',
      price: 450,
      brand: 'Cognac',
      productCattitle: 'Distilled spirit type',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 20,
      image: 'assets/images/pierry.jpg',
      title: 'Pierre Ferrand',
      desc: 'Cognac is a type of brandy',
      price: 340,
      brand: 'Cognac',
      productCattitle: 'Distilled spirit type',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 21,
      image: 'assets/images/brandy1.jpg',
      title: ' McDowell’s No 1',
      desc: 'Brandy is a liquor produced by distilling wine. ',
      price: 340,
      brand: 'Brandy',
      productCattitle: 'Alcohol',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 22,
      image: 'assets/images/mansion.jpg',
      title: 'Mansion House',
      desc: 'Brandy is a liquor produced by distilling wine. ',
      price: 940,
      brand: 'Brandy',
      productCattitle: 'Alcohol',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 23,
      image: 'assets/images/honey.jpg',
      title: 'Honey Bee',
      desc: 'Brandy is a liquor produced by distilling wine. ',
      price: 3340,
      brand: 'Brandy',
      productCattitle: 'Alcohol',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 24,
      image: 'assets/images/Dreher.jpg',
      title: 'Dreher',
      desc: 'Brandy is a liquor produced by distilling wine. ',
      price: 320,
      brand: 'Brandy',
      productCattitle: 'Alcohol',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 25,
      image: 'assets/images/OldAdmiral.jpg',
      title: 'Old Admiral',
      desc: 'Brandy is a liquor produced by distilling wine. ',
      price: 1340,
      brand: 'Brandy',
      productCattitle: 'Alcohol',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 26,
      image: 'assets/images/ChivasRegal.png',
      title: 'Chivas Regal',
      desc:
          'Whisky or whiskey is a type of distilled alcoholic beverage made from fermented grain mash. ',
      price: 3645,
      brand: 'Whiskey',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 27,
      image: 'assets/images/Ballantine’s_Finest.png',
      title: 'Ballantine’s Finest',
      desc:
          'Whisky or whiskey is a type of distilled alcoholic beverage made from fermented grain mash. ',
      price: 1645,
      brand: 'Whiskey',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 28,
      image: 'assets/images/The_Glenlivet.png',
      title: 'The Glenlivet',
      desc:
          'Whisky or whiskey is a type of distilled alcoholic beverage made from fermented grain mash. ',
      price: 3530,
      brand: 'Whiskey',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: false,
    ),
    Product(
      id: 29,
      image: 'assets/images/Jack_Daniels.png',
      title: 'Jack Daniel’s',
      desc:
          'Whisky or whiskey is a type of distilled alcoholic beverage made from fermented grain mash. ',
      price: 2630,
      brand: 'Whiskey',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: true,
    ),
    Product(
      id: 30,
      image: 'assets/images/Johnnie_Walker.png',
      title: 'Johnnie Walker',
      desc:
          'Whisky or whiskey is a type of distilled alcoholic beverage made from fermented grain mash. ',
      price: 4630,
      brand: 'Whiskey',
      productCattitle: 'Alcoholic beverages',
      isFavorite: false,
      isPopuler: false,
    ),
  ];

  List<Product> get productList {
    return product;
  }

  List<Product> findByCategory(String categoryName) {
    List categoryList = product
        .where(
          (element) => element.brand.toLowerCase().contains(
                categoryName.toLowerCase(),
              ),
        )
        .toList();
    return [...categoryList];
  }

  List<Product> findByBrand(String brandName) {
    List _categoryList = product
        .where(
          (element) => element.brand.toLowerCase().contains(
                brandName.toLowerCase(),
              ),
        )
        .toList();
    return [..._categoryList];
  }

  List<Product> get populerProduct {
    return product.where((element) => element.isPopuler).toList();
  }

  Product findById(String brandId) {
    return product.firstWhere(
      (element) => element.id.toString() == brandId,
    );
  }

  List<Product> searchBrand(String searchText) {
    List _searchList = product
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return [..._searchList];
  }

}
