// ignore_for_file: prefer_const_constructors

import 'package:eshop/screens/feeds.dart';
import 'package:flutter/material.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({Key? key}) : super(key: key);

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
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: themeChange.darkTheme
                    ? AssetImage('assets/images/wishlist.png')
                    : AssetImage('assets/images/wishlist.png'),
              ),
            ),
          ),
          Text(
            "Your wishlist is empty",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeChange.darkTheme
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).textSelectionTheme.selectionColor,
              fontSize: 24,
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
                Navigator.of(context)
                    .pushReplacementNamed(FeedsScreen.routeName);
              },
              child: Text(
                "Add your wishes here 😊".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
