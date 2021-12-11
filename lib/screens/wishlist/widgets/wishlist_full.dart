import 'package:eshop/models/wishlist_product.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/services/global_alert_method.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullWishlist extends StatefulWidget {
  final String wishlistProductId;

  const FullWishlist({
    Key? key,
    required this.wishlistProductId,
  }) : super(key: key);

  @override
  _FullWishlistState createState() => _FullWishlistState();
}

class _FullWishlistState extends State<FullWishlist> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final wishListProduct = Provider.of<WishListProduct>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    GlobalAlertMethod alertMethod = GlobalAlertMethod();
    return Container(
      height: 200,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        color: !themeChange.darkTheme
            ? Theme.of(context).backgroundColor
            : Theme.of(context).disabledColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        wishListProduct.imageUrl,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wishListProduct.name,
                        style: const TextStyle(
                          // fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${(wishListProduct.price * 73).round()} ₹",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: themeChange.darkTheme
                              ? Theme.of(context).canvasColor
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Flexible(
                        child: Text(
                          "FREE Shipping",
                          style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            color: themeChange.darkTheme
                                ? Theme.of(context).canvasColor
                                : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                          // height: 15,
                          ),
                      // const Flexible(
                      //   child: Text(
                      //     "In stock",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w900,
                      //       color:
                      //           // themeChange.darkTheme
                      //           //     ? Theme.of(context).canvasColor :
                      //           Colors.green,
                      //     ),
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            // ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.025),
                      border: Border.all(
                        color: Theme.of(context).textSelectionColor,
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Move to cart",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.025),
                      border: Border.all(
                        color: Theme.of(context).textSelectionColor,
                        width: 2,
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        alertMethod.myShowDialog(
                          context,
                          "Deletion from wishlist",
                          "Do you really want to remove ${wishListProduct.name} from your wish list?",
                          () => wishListProvider.removeProductFromWishList(
                            widget.wishlistProductId,
                          ),
                        );
                      },
                      icon: Icon(Icons.delete,
                          // color: Colors.grey.shade400,
                          color: Theme.of(context).accentColor),
                      label: Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            // color: Colors.grey.shade400,
                            // color: Theme.of(context).buttonColor,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
