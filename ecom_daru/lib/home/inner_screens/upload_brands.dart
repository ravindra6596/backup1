import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:ecom_daru/widgets/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadBrands extends StatefulWidget {
  static const routeName = '/uploadProductScreen';
  const UploadBrands({Key? key}) : super(key: key);

  @override
  _UploadBrandsState createState() => _UploadBrandsState();
}

class _UploadBrandsState extends State<UploadBrands>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  var brandTitle = '';
  var brandPrice = '';
  var brandCategory = '';
  var brandDescription = '';
  var brandType = '';
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  String? categoryValue;
  String? brandValue;
  void submitBrandForm() {
    final isValidate = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidate) {
      formKey.currentState!.save();
      print(brandTitle);
      print(brandCategory);
      print(brandDescription);
      print(brandPrice);
      print(brandType);
    }
  }

  List brandDropDownList = [
    {'no': 1, 'brand': 'Wine'},
    {'no': 2, 'brand': 'Vodka'},
    {'no': 3, 'brand': 'Beer'},
    {'no': 4, 'brand': 'Rum'},
    {'no': 5, 'brand': 'Whiskey'},
    {'no': 6, 'brand': 'Brandy'},
    {'no': 7, 'brand': 'Cognac'},
  ];
  List categoryDropDownList = [
    {'no': 1, 'productCattitle': 'Alcohol'},
    {'no': 2, 'productCattitle': 'Alcoholic beverages'},
    {'no': 3, 'productCattitle': 'Distilled spirit type'},
    {'no': 4, 'productCattitle': 'Alcoholic drink'},
  ];

  List<DropdownMenuItem<Object?>> brandsDropdownItems = [];
  List<DropdownMenuItem<Object?>> categoryDropdownItems = [];
  var selectedBrand;
  var selectedCategory;

  @override
  void initState() {
    brandsDropdownItems = brandDropdownTestItems(brandDropDownList);
    categoryDropdownItems = categoryDropdownTestItems(categoryDropDownList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Object?>> brandDropdownTestItems(List catList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in catList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['brand'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Object?>> categoryDropdownTestItems(List catList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in catList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['productCattitle'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Brand'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: PickImage(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 2),
                          child: TextFormField(
                            key: ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Brand Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Brand Name',
                              hintText: 'Brand Name',
                            ),
                            onSaved: (value) {
                              brandTitle = value!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 2,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 3),
                          child: TextFormField(
                            key: ValueKey('Price'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Price';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Price',
                              hintText: '0.00',
                            ),
                            onSaved: (value) {
                              brandTitle = value!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 4),
                          child: Text('Select Category'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Select Brand'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 4),
                          child: DropdownBelow(
                            itemWidth: 220,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                            boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                            boxWidth: 230,
                            boxHeight: 55,
                            boxDecoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: .8,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            hint: Text(
                              'Category',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            value: selectedCategory,
                            items: categoryDropdownItems,
                            onChanged: (selectedTest) {
                              setState(() {
                                selectedCategory = selectedTest;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: DelayedDisplay(
                          delay: Duration(seconds: 5),
                          child: DropdownBelow(
                            itemWidth: 150,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                            boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                            boxWidth: 210,
                            boxHeight: 55,
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            hint: Text(
                              'Brand',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            value: selectedBrand,
                            items: brandsDropdownItems,
                            onChanged: (selectedTest) {
                              setState(() {
                                selectedBrand = selectedTest;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DelayedDisplay(
                    delay: Duration(seconds: 6),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description Can\`t Be Empty.';
                        }
                        return null;
                      },
                      minLines: 10,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Brand Description',
                        prefixIcon: Icon(
                          Icons.note_add,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: DelayedDisplay(
        delay: Duration(seconds: 7),
        child: Container(
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.upload,
                ),
                label: Text(
                  'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
