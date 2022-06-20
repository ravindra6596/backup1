import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/widgets/removeMyCartItemAlert.dart';
import 'package:ecom_daru/wishlist/emptyWishList.dart';
import 'package:ecom_daru/wishlist/fullWishList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);
  static const routeName = '/WishListScreen';
//31 episode is start
  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    return favouriteProvider.getfavouriteItems.isEmpty
        ? Scaffold(
            body: EmptyWishList(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'WishList (${favouriteProvider.getfavouriteItems.length})',
              ),
              actions: [
                IconButton(
                  onPressed: () => removeItemAlert(
                    context,
                    'Clear Favourites',
                    'Your Favourite Lists will be Cleared !',
                    () => favouriteProvider.clearFavourite(),
                  ),
                  icon: Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  itemCount: favouriteProvider.getfavouriteItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value: favouriteProvider.getfavouriteItems.values
                          .toList()[index],
                      child: FullWishList(
                        productId: favouriteProvider.getfavouriteItems.keys
                            .toList()[index],
                      ),
                    );
                  }),
            ),
          );
  }
}
