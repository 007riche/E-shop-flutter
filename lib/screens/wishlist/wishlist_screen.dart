// ignore_for_file: prefer_const_constructors

import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/screens/wishlist/widgets/wishlist_empty_widget.dart';
import 'package:eshop/screens/wishlist/widgets/wishlist_full.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);
  static const routeName = "/Wishlist-screen";

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    return wishListProvider.getWishListItems.isEmpty
        ? SafeArea(
            child: Scaffold(
              appBar: AppBar(
                // actions: const [
                //   IconButton(
                //     splashColor: Colors.transparent,
                //     onPressed: null,
                //     icon: Icon(
                //       AppIcons.trashDisabled,
                //       size: 32,
                //     ),
                //   )
                // ],
                title: Text(
                  " My Wishlist",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                // foregroundColor: Theme.of(context).buttonColor,
                // leading: IconButton(
                //   splashColor: Colors.transparent,
                //   onPressed: () {},
                //   icon: Icon(
                //     AppIcons.backPage,
                //     size: 24,
                //   ),
                // ),
              ),
              body: EmptyWishlist(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                // actions: [
                //   IconButton(
                //     splashColor: Colors.transparent,
                //     highlightColor: Theme.of(context).accentColor,
                //     onPressed: () {},
                //     icon: Icon(
                //       AppIcons.trash,
                //     ),
                //   )
                // ],
                title: Text(
                  " My Wishlist",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                // foregroundColor: Theme.of(context).buttonColor,
                // leading: IconButton(
                //   splashColor: Colors.transparent,
                //   onPressed: () {},
                //   icon: Icon(
                //     AppIcons.backPage,
                //     size: 24,
                //   ),
                // ),
              ),
              body: ListView.builder(
                itemCount: wishListProvider.getWishListItems.length,
                itemBuilder: (BuildContext localCtx, int index) {
                  return ChangeNotifierProvider.value(
                    value: wishListProvider.getWishListItems.values
                        .toList()[index],
                    child: FullWishlist(
                      wishlistProductId: wishListProvider.getWishListItems.keys
                          .toList()[index],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
