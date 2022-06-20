import 'package:ecom_daru/products/product.dart';
import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularBrands extends StatelessWidget {
/*   const PopularBrands({
    Key? key,
    required this.image,
    required this.title,
    required this.desc,
    required this.price,
  }) : super(key: key);

  final String image;
  final String title;
  final String desc;
  final String price; */
  @override
  Widget build(BuildContext context) {
    final popProduct = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        BrandDetails.routeName,
        arguments: popProduct.id.toString(),
      ),
      child: Container(
        width: 250,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        popProduct.image,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 12,
                    top: 10,
                    child: IconButton(
                      onPressed:
                          favouriteProvider.getfavouriteItems.containsKey(
                        popProduct.id.toString(),
                      )
                              ? () {}
                              : () {
                                  favouriteProvider.addRemoveFavourite(
                                    popProduct.id.toString(),
                                    popProduct.price,
                                    popProduct.title,
                                    popProduct.image,
                                    popProduct.productCattitle,
                                  );
                                },
                      icon: favouriteProvider.getfavouriteItems.containsKey(
                        popProduct.id.toString(),
                      )
                          ? Icon(
                              Icons.star,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.star_border,
                              color: Colors.white,
                            ),
                    )),
                Positioned(
                  right: 12,
                  bottom: 30,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white70,
                    child: Text(
                      '₹ ${popProduct.price}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      popProduct.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            popProduct.desc,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: cartProvider.getCartItems
                                  .containsKey(popProduct.id)
                              ? () {}
                              : () {
                                  cartProvider.addBrandToCart(
                                    popProduct.id.toString(),
                                    popProduct.price,
                                    popProduct.title,
                                    popProduct.image,
                                    popProduct.productCattitle,
                                  );
                                },
                          icon: cartProvider.getCartItems
                                  .containsKey(popProduct.id.toString())
                              ? Icon(Icons.check)
                              : Icon(Icons.add_shopping_cart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
