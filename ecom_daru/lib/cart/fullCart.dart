import 'package:ecom_daru/products/cart_Attribute.dart';
import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:ecom_daru/widgets/removeMyCartItemAlert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  final String productId;

  const FullCart({
    required this.productId,
  });
  /*  const FullCart({
    required this.id,
    required this.brandId,
    required this.title,
    required this.image,
    required this.productCattitle,
    required this.price,
    required this.quantity,
  });
  final String id;
  final String brandId;
  final String title;
  final String productCattitle;
  final String image;
  final double price;
  final int quantity;
 */
  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final cartAttribute = Provider.of<CartAttribute>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttribute.price * cartAttribute.quantity;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        BrandDetails.routeName,
        arguments: widget.productId,
      ),
      child: Container(
        height: 120,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: .2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      cartAttribute.image,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartAttribute.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            removeItemAlert(
                              context,
                              'Remove Item',
                              'Are you sure you want to remove this item.',
                              () => cartProvider.removeItem(widget.productId),
                            );
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartAttribute.productCattitle.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          cartAttribute.price.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$subTotal',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        margin: EdgeInsets.all(10),
                        height: 35.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.remove,
                                color: Colors.green,
                              ),
                              onTap: cartAttribute.quantity < 2
                                  ? null
                                  : () {
                                      cartProvider.removeCartItemByOne(
                                        widget.productId,
                                      
                                      );
                                    },
                            ),
                            Spacer(),
                            Text(
                              cartAttribute.quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 16.0),
                            ),
                            Spacer(),
                            InkWell(
                              child: Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              onTap: () {
                                cartProvider.addBrandToCart(
                                  widget.productId,
                                  cartAttribute.price,
                                  cartAttribute.title,
                                  cartAttribute.image,
                                  cartAttribute.productCattitle,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
