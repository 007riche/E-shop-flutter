import 'package:eshop/screens/uplaod_product_form.dart';
import 'package:eshop/screens/bottom_bar.dart';
import 'package:eshop/screens/landing_page.dart';
import 'package:flutter/material.dart';

class MainScreens extends StatelessWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomBarScreen(), //LandingPage(),
        UploadProductForm(),
      ],
    );
  }
}
