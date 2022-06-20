import 'dart:convert';
import 'dart:io';
import 'package:ecom_daru/jobs.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import 'package:ecom_daru/products/feedBrands.dart';
import 'package:ecom_daru/products/product.dart';
import 'package:ecom_daru/provider/cart_provider.dart';
import 'package:ecom_daru/provider/favourite_provider.dart';
import 'package:ecom_daru/provider/products_provider.dart';
import 'package:ecom_daru/wishlist/wishList.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController? searchController;
  final FocusNode? focusNode = FocusNode();
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode!.dispose();
    searchController!.dispose();
  }

  TextEditingController currencyControler = TextEditingController();
 // static const _localeString = 'en';
  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  List<Product> searchList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    List<Product> productsList = productProvider.product;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Search Here',
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(6),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    controller: searchController,
                    minLines: 1,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController!.clear();
                          focusNode!.unfocus();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: searchController!.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      searchController!.text.toLowerCase();
                      setState(() {
                        searchList = productProvider.searchBrand(value);
                      });
                    },
                  ),
                ),
             
               /*  TextFormField(
                  controller: currencyControler,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.money,
                      )),
                  keyboardType: TextInputType.number,
                  onChanged: (string) {
                    string = '${formNum(
                      string.replaceAll(',', ''),
                    )}';
                    currencyControler.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(
                        offset: string.length,
                      ),
                    );
                  },
                ),
               */  /*  TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Jobs(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                  ),
                ), */

                Container(
                  child: searchController!.text.isNotEmpty && searchList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Icon(
                              Icons.search,
                              size: 60,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'No result found!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            searchController!.text.isEmpty
                                ? productsList.length
                                : searchList.length,
                            (index) {
                              return ChangeNotifierProvider.value(
                                value: searchController!.text.isEmpty
                                    ? productsList[index]
                                    : searchList[index],
                                child: FeedBrands(),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        /* floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Jobs(),
            ),
          ),
        ), */
      ),
    );
  }
}
