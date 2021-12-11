// ignore_for_file: prefer_const_constructors

import 'package:eshop/screens/feeds.dart';
import 'package:flutter/material.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class UserEmptyOrders extends StatelessWidget {
  const UserEmptyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.redAccent,
      elevation: 12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );

    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Text(
            "Your order list is empty",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeChange.darkTheme
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).textSelectionTheme.selectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.1,
            child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Navigator.of(context).pushNamed(FeedsScreen.routeName);
              },
              child: Text(
                "Start shopping now".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    // fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
