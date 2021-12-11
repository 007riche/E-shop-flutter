import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/models/cart_product.dart';
import 'package:eshop/models/order.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/orders_provider.dart';
import 'package:eshop/services/global_alert_method.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class UserOrdersFull extends StatefulWidget {
  // final String productId;

  const UserOrdersFull({
    Key? key,
    // required this.productId,
  }) : super(key: key);

  @override
  _UserOrdersFullState createState() => _UserOrdersFullState();
}

class _UserOrdersFullState extends State<UserOrdersFull> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // final cartProduct = Provider.of<CartProduct>(context);
    final orderProvider = Provider.of<OrdersProvider>(context);
    bool detectDragDirection = false;
    GlobalAlertMethod alertMethod = GlobalAlertMethod();
    final order = Provider.of<Order>(context);

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
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetails.routeName,
                      arguments: order.productId,
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          // 'https://cdn.shopify.com/s/files/1/0057/8938/4802/files/2_a25aff7a-b5c4-4565-a111-6e1ce2d5b5f0.png?v=1624268771',
                          order.imageUrl,
                          // cartProduct.imageUrl,
                        ),
                        fit: BoxFit.contain,
                      ),
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
                        // "tttttttttttttttttttttttttttttttttttfgttfgfgfgtttAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
                        "${order.name}",
                        style: const TextStyle(
                          // fontSize: 16,
                          fontWeight: FontWeight.normal,
                          // color: themeChange.darkTheme
                          //     ? Theme.of(context)
                          //         .textSelectionTheme
                          //         .selectionColor
                          //     : Colors.black87,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "₹ ${order.price}",
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
                      // Flexible(
                      //   child: Text(
                      //     "FREE Shipping",
                      //     style: TextStyle(
                      //       // fontWeight: FontWeight.w900,
                      //       color: themeChange.darkTheme
                      //           ? Theme.of(context).canvasColor
                      //           : Colors.black,
                      //     ),
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      // const SizedBox(
                      //     // height: 15,
                      //     ),
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
        ],
      ),
    );
  }
}
