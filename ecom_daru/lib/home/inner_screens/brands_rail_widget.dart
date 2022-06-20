import 'package:ecom_daru/products/product.dart';
import 'package:ecom_daru/screens/brandDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandsNavigationRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productDetail = Provider.of<Product>(context);
    return SafeArea(
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          BrandDetails.routeName,
          arguments: productDetail.id.toString(),
        ),
        child: Container(
          // color: Colors.red,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 5.0,
          ),
          margin: EdgeInsets.only(
            right: 20.0,
            bottom: 5,
            top: 18,
          ),
          constraints: BoxConstraints(
            minHeight: 150,
            minWidth: double.infinity,
            maxHeight: 150,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        productDetail.image,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0)
                    ],
                  ),
                ),
              ),
              FittedBox(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10.0)
                      ]),
                  width: 300,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productDetail.title,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FittedBox(
                        child: Text(productDetail.price.toString(),
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30.0,
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(productDetail.productCattitle,
                          style: TextStyle(color: Colors.grey, fontSize: 25.0)),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
