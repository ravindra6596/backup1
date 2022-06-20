import 'package:ecom_daru/products/feedBrands.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorisFeeds extends StatelessWidget {
  static const routName = '/CategorisFeeds';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context,listen: false,);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final productsList = productProvider.findByCategory(categoryName);
    return SafeArea(
      child: Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(productsList.length, (index) {
            return ChangeNotifierProvider.value(
              value: productsList[index],
              child: FeedBrands(),
            );
          }),
        ),
      ),
    );
  }
}
