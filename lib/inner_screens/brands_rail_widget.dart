// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandsNavigationRail extends StatelessWidget {
  static get context => null;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final productAttributes = Provider.of<Product>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetails.routeName,
          arguments: productAttributes.id,
          // [
          //   productAttributes.imageUrl,
          //   productAttributes.name,
          //   productAttributes.description,
          //   productAttributes.price,
          // ],
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        margin: EdgeInsets.only(right: 20.0, bottom: 5, top: 18),
        constraints: BoxConstraints(
            minHeight: 150, minWidth: double.infinity, maxHeight: 180),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(
                      // 'https://cdn.shopify.com/s/files/1/0057/8938/4802/files/2_a25aff7a-b5c4-4565-a111-6e1ce2d5b5f0.png?v=1624268771',
                      productAttributes.imageUrl![0],
                    ),
                    fit: BoxFit.contain),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: themeChange.darkTheme ? Colors.white : Colors.grey,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0)
                ],
              ),
            ),
            FittedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: themeChange.darkTheme
                              ? Colors.amber
                              : Colors.grey,
                          offset: Offset(7.0, 5.0),
                          blurRadius: 10.0)
                    ]),
                // constraints: BoxConstraints(maxHeight: 250),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      // 'title',
                      productAttributes.name,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      child: Text(
                          'INR ${(productAttributes.price! * 73).round()}₹',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30.0,
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      // 'CatergoryName',
                      productAttributes.productCategories![0],
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    ),
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
    );
  }
}
