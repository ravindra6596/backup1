import 'package:ecom_daru/products/favourite_Attributes.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/widgets/removeMyCartItemAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullWishList extends StatefulWidget {
  const FullWishList({
    required this.productId,
  });
  final String productId;
  @override
  _FullWishListState createState() => _FullWishListState();
}

class _FullWishListState extends State<FullWishList> {
  @override
  Widget build(BuildContext context) {
    final favouriteAttributes = Provider.of<FavouriteAttributes>(context);
    return Container(
      margin: EdgeInsets.all(3),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(
              10,
            ),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
              elevation: 3,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              favouriteAttributes.image,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: 80,
                        width: 130,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favouriteAttributes.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              favouriteAttributes.price.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          removeWishItem(widget.productId),
        ],
      ),
    );
  }

  removeWishItem(String productId) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return Positioned(
      top: 40,
      right: -1,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          onPressed: () {
            removeItemAlert(
              context,
              'Remove Favourites',
              'This Item will be Remove From Favourites!',
              () => favouriteProvider.removeFavouriteItem(productId),
            );
          },
          //
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(0),
          color: Colors.redAccent,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
