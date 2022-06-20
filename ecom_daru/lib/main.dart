import 'package:ecom_daru/home/inner_screens/brands_navigation_rail.dart';
import 'package:ecom_daru/home/inner_screens/categories_feeds.dart';
import 'package:ecom_daru/home/inner_screens/upload_brands.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:ecom_daru/screens/cart.dart';
import 'package:ecom_daru/widgets/Tabbar.dart';
import 'package:ecom_daru/widgets/landingPage.dart';
import 'package:ecom_daru/wishlist/wishList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'screens/feeds.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
        routes: {
          BrandNavigationRailScreen.routeName: (ctx) =>
              BrandNavigationRailScreen(),
          Cart.routeName: (ctx) => Cart(),
          WishList.routeName: (ctx) => WishList(),
          BrandDetails.routeName: (ctx) => BrandDetails(),
          Feeds.routName: (ctx) => Feeds(),
          CategorisFeeds.routName: (ctx) => CategorisFeeds(),
          TabBarTest.routeName: (context) => TabBarTest(),
          UploadBrands.routeName: (context) => UploadBrands(),
        },
      ),
    );
  }
}
