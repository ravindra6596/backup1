import 'package:badges/badges.dart';
import 'package:ecom_daru/products/feeds_Dialog.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product.dart';

class FeedBrands extends StatefulWidget {
  @override
  _FeedBrandsState createState() => _FeedBrandsState();
}

class _FeedBrandsState extends State<FeedBrands> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Product>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        BrandDetails.routeName,
        arguments: productProvider.id.toString(),
      ),
      child: Container(
        width: 250,
        height: 290,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    productProvider.image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  child: Divider(
                    color: Colors.black,
                  ),
                  height: 15,
                ),
                Text(
                  productProvider.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${productProvider.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => FeedDialog(
                              productId: productProvider.id.toString(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 6),
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Badge(
              shape: BadgeShape.square,
              badgeColor: Colors.blue,
              borderRadius: BorderRadius.circular(8),
              badgeContent: Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
