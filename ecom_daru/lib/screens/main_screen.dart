import 'package:ecom_daru/bottombar/bottom_bar.dart';
import 'package:ecom_daru/home/inner_screens/upload_brands.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomNavigationBarScreen(),
        UploadBrands(),
      ],
    );
  }
}
