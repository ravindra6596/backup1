import 'package:ecom_daru/cart/emptyCart.dart';
import 'package:ecom_daru/cart/fullCart.dart';
import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/widgets/removeMyCartItemAlert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
  static const routeName = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              //   backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Cart Items (${cartProvider.getCartItems.length})',
                style: TextStyle(
                    //  color: Colors.black,
                    ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    removeItemAlert(
                      context,
                      'Clear Cart',
                      'Are you sure you want to Clear your Cart.',
                      () => cartProvider.clearCart(),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    // color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Container(
              //color: Theme.of(context).backgroundColor,
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: FullCart(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                        /*   id: cartProvider.getCartItems.values.toList()[index].id,
                        brandId: cartProvider.getCartItems.keys.toList()[index],
                        title: cartProvider.getCartItems.values
                            .toList()[index]
                            .title,
                        productCattitle: cartProvider.getCartItems.values
                            .toList()[index]
                            .productCattitle,
                        image: cartProvider.getCartItems.values
                            .toList()[index]
                            .image,
                        price: cartProvider.getCartItems.values
                            .toList()[index]
                            .price,
                        quantity: cartProvider.getCartItems.values
                            .toList()[index]
                            .quantity, */
                      ),
                    );
                  }),
            ),
            bottomSheet: checkoutSection(cartProvider.totalAmount),
          );
  }

  checkoutSection(double total) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: .5,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '₹ $total',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              //  margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                //borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Checkout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
