import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
      context,
      listen: false,
    );
    final proId = productsData.findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    List<IconData> icondata = [
      favouriteProvider.getfavouriteItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Icons.remove_red_eye,
      Icons.shopping_cart,
    ];

    List<String> texts = [
      favouriteProvider.getfavouriteItems.containsKey(productId)
          ? 'In Wishlist'
          : 'Add To Wishlist',
      'View Product',
      cartProvider.getCartItems.containsKey(productId)
          ? 'In Cart'
          : 'Add to Cart'
    ];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 5,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.asset(
                proId.image,
              ),
            ),
            Container(
              height: 100,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: dialogContent(
                      context,
                      0,
                      () => {
                        favouriteProvider.addRemoveFavourite(
                          productId,
                          proId.price,
                          proId.title,
                          proId.image,
                          proId.productCattitle,
                        ),
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null,
                      },
                    ),
                  ),
                  Expanded(
                    child: dialogContent(
                      context,
                      1,
                      () => {
                        Navigator.pushNamed(
                          context,
                          BrandDetails.routeName,
                          arguments: proId.id.toString(),
                        ).then(
                          (value) => Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null,
                        )
                      },
                    ),
                  ),
                  Expanded(
                    child: dialogContent(
                      context,
                      2,
                      () => {
                        cartProvider.addBrandToCart(
                          productId,
                          proId.price,
                          proId.title,
                          proId.image,
                          proId.productCattitle,
                        ),
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null,
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.3,
                ),
                shape: BoxShape.circle,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dialogContent(BuildContext context, int index, Function function) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    List<IconData> icondata = [
      favouriteProvider.getfavouriteItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Icons.remove_red_eye,
      cartProvider.getCartItems.containsKey(productId)
          ? Icons. shopping_cart
          : Icons.add_shopping_cart,
    ];

    List<String> texts = [
      favouriteProvider.getfavouriteItems.containsKey(productId)
          ? 'In Wishlist'
          : 'Add To Wishlist',
      'View Product',
      cartProvider.getCartItems.containsKey(productId)
          ? 'In Cart'
          : 'Add to Cart'
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 25,
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        icondata[index],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
