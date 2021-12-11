import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/models/cart_product.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
// import 'package:eshop/provider/dark_theme_provider.dart';
// import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  final String productId;

  const FullCart({
    Key? key,
    required this.productId,
  }) : super(key: key);

  // const FullCart({Key? key}) : super(key: key);
  // final String id;
  // final String productId;
  // final String name;
  // final String imageUrl;
  // final double price;
  // final int quantity;

  // const FullCart({
  //   Key? key,
  //   // required this.id,
  //   // required this.productId,
  //   // required this.name,
  //   // required this.imageUrl,
  //   // required this.price,
  //   // required this.quantity,
  // }); // : super(key: key);

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // final ButtonStyle style = OutlinedButton.styleFrom(
    //   fixedSize: Size.fromWidth(5),
    //   // maximumSize: Size(15.0, 15.0),
    // );
    final cartProduct = Provider.of<CartProduct>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishListProvider>(context);
    bool detectDragDirection = false;
    GlobalAlertMethod alertMethod = GlobalAlertMethod();

    return Dismissible(
      behavior: HitTestBehavior.translucent,
      key: ValueKey(widget.productId),
      direction: DismissDirection.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      background: Container(
        height: 200,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(
          left: 12,
        ),
        alignment: Alignment.centerLeft,
        child: const Text(
          "Save for later",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      secondaryBackground: Container(
        height: 200,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(
          right: 15,
        ),
        alignment: Alignment.centerRight,
        child: const Text(
          "Delete",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      dismissThresholds: const {
        DismissDirection.endToStart: 0.5,
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 6.0,
                      ),
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/OOjs_UI_icon_alert_destructive_black-darkred.svg/1138px-OOjs_UI_icon_alert_destructive_black-darkred.svg.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Remove this item!",
                      ),
                    ),
                  ],
                ),
                content: Text(
                  "Are you sure you want to delete ${cartProduct.name} from your cart?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      cartProvider.removeProductFromCart(widget.productId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          dismissDirection: DismissDirection.endToStart,
                          content: Text(
                              "${cartProduct.name} is successfully deleted from your cart"),
                          action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                cartProvider.addProductToCart(
                                    widget.productId,
                                    cartProduct.price,
                                    cartProduct.name,
                                    cartProduct.imageUrl);
                              }),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Yes"),
                  ),
                ],
              );
            },
          );
        } else {
          wishlistProvider.addAndRemoveProductToWishList(widget.productId,
              cartProduct.price, cartProduct.name, cartProduct.imageUrl);
          cartProvider.removeProductFromCart(widget.productId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.up,
              content: Text(
                  "${cartProduct.name} is successfully added to your wishlist"),
              action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    wishlistProvider.addAndRemoveProductToWishList(
                        widget.productId,
                        cartProduct.price,
                        cartProduct.name,
                        cartProduct.imageUrl);
                    cartProvider.addProductToCart(
                        widget.productId,
                        cartProduct.price,
                        cartProduct.name,
                        cartProduct.imageUrl);
                  }),
            ),
          );
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            detectDragDirection = true;
          });
          cartProvider.removeProductFromCart(widget.productId);
        } else if (direction == DismissDirection.startToEnd) {
          setState(() {
            detectDragDirection = false;
          });
        }
      },
      child: Container(
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
                        arguments: widget.productId,
                        // [
                        //   productAttributes.imageUrl,
                        //   productAttributes.name,
                        //   productAttributes.description,
                        //   productAttributes.price,
                        // ],
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            // 'https://cdn.shopify.com/s/files/1/0057/8938/4802/files/2_a25aff7a-b5c4-4565-a111-6e1ce2d5b5f0.png?v=1624268771',
                            // 'https://cdn1.ethoswatches.com/media/mobile/new-arrivals/mobile-new-watches-23-04-21.jpg',
                            cartProduct.imageUrl,
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
                          "${cartProduct.name}",
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
                          "₹ ${(cartProduct.price * 73).round()}",
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
                        const Flexible(
                          child: Text(
                            "In stock",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color:
                                  // themeChange.darkTheme
                                  //     ? Theme.of(context).canvasColor :
                                  Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      // used padding just for demo purpose to separate from the appbar and the main content
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.black54,
                          borderRadius: BorderRadius.circular(
                            // Radius.circular(10),
                            10.0,
                          ),
                          // border: Border.all(
                          //   width: 1,
                          // ),
                        ),
                        alignment: Alignment.topCenter,
                        child: Container(
                            height: 30,
                            // padding: const EdgeInsets.all(2),
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Material(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: cartProduct.quantity < 2
                                          ? null
                                          : () {
                                              cartProvider
                                                  .reduceProductByOneFromCart(
                                                widget.productId,
                                                cartProduct.price,
                                                cartProduct.name,
                                                cartProduct.imageUrl,
                                              );
                                            },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(2),
                                            topLeft: Radius.circular(2),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.remove,
                                            color: themeChange.darkTheme
                                                ? Theme.of(context).buttonColor
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.symmetric(
                                      //   horizontal: BorderSide(
                                      //     width: 0.5,
                                      //   ),
                                      // ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      // "10",
                                      "${cartProduct.quantity}",
                                      style: TextStyle(
                                        // ignore: deprecated_member_use
                                        color: themeChange.darkTheme
                                            ? Theme.of(context).buttonColor
                                            : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Material(
                                    borderOnForeground: false,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(2),
                                      topRight: Radius.circular(7),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        cartProvider.addProductToCart(
                                          widget.productId,
                                          cartProduct.price,
                                          cartProduct.name,
                                          cartProduct.imageUrl,
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          // borderRadius: BorderRadius.only(
                                          //   bottomRight: Radius.circular(60),
                                          //   topRight: Radius.circular(60),
                                          // ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.add,
                                            color: themeChange.darkTheme
                                                ? Theme.of(context).buttonColor
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.005,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton.icon(
                        onPressed: () {
                          alertMethod.myShowDialog(
                            context,
                            "Remove this item!",
                            "Are you sure you want to delete ${cartProduct.name} from your cart?",
                            () {
                              cartProvider
                                  .removeProductFromCart(widget.productId);
                            },
                          );
                        },
                        icon: Icon(Icons.delete,
                            // color: Colors.grey.shade400,
                            color: themeChange.darkTheme
                                ? Theme.of(context).buttonColor
                                : Theme.of(context).accentColor),
                        label: Text(
                          'Delete',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // color: Colors.grey.shade400,
                              // color: Theme.of(context).buttonColor,
                              color: themeChange.darkTheme
                                  ? Theme.of(context).buttonColor
                                  : Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.005,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Save for later",
                      ),
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





















// ================================================================================== Dismissible

// Dismissible(
//       behavior: HitTestBehavior.translucent,
//       key: ValueKey(widget.productId),
//       direction: DismissDirection.horizontal,
//       dragStartBehavior: DragStartBehavior.start,
//       background: Container(
//         height: 200,
//         margin: const EdgeInsets.all(12),
//         padding: const EdgeInsets.only(
//           left: 12,
//         ),
//         alignment: Alignment.centerLeft,
//         child: const Text(
//           "Save for later",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.all(
//             Radius.circular(16),
//           ),
//         ),
//       ),
//       secondaryBackground: Container(
//         height: 200,
//         margin: const EdgeInsets.all(12),
//         padding: const EdgeInsets.only(
//           right: 15,
//         ),
//         alignment: Alignment.centerRight,
//         child: const Text(
//           "Delete",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//         decoration: BoxDecoration(
//           color: Colors.red.shade900,
//           borderRadius: BorderRadius.all(
//             Radius.circular(16),
//           ),
//         ),
//       ),
//       dismissThresholds: const {
//         DismissDirection.endToStart: 0.5,
//       },
//       confirmDismiss: (direction) async {
//         if (direction == DismissDirection.endToStart) {
//           return showDialog(
//             context: context,
//             builder: (BuildContext ctx) {
//               return AlertDialog(
//                 title: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         right: 6.0,
//                       ),
//                       child: Image.network(
//                         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/OOjs_UI_icon_alert_destructive_black-darkred.svg/1138px-OOjs_UI_icon_alert_destructive_black-darkred.svg.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Remove this item!",
//                       ),
//                     ),
//                   ],
//                 ),
//                 content: Text(
//                   "Are you sure you want to delete ${cartProduct.name} from your cart?",
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("No"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       cartProvider.removeProductFromCart(widget.productId);
//                       Navigator.pop(context);
//                     },
//                     child: Text("Yes"),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//       onDismissed: (direction) {
//         if (direction == DismissDirection.endToStart) {
//           setState(() {
//             detectDragDirection = true;
//           });
//           cartProvider.removeProductFromCart(widget.productId);
//         } else if (direction == DismissDirection.startToEnd) {
//           setState(() {
//             detectDragDirection = false;
//           });
//         }
//       },
//       child: Container(
//         height: 200,
//         margin: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(16),
//           ),
//           color: !themeChange.darkTheme
//               ? Theme.of(context).backgroundColor
//               : Theme.of(context).disabledColor,
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 140,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).pushNamed(
//                         ProductDetails.routeName,
//                         arguments: widget.productId,
//                         // [
//                         //   productAttributes.imageUrl,
//                         //   productAttributes.name,
//                         //   productAttributes.description,
//                         //   productAttributes.price,
//                         // ],
//                       );
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.25,
//                       height: MediaQuery.of(context).size.width * 0.25,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             // 'https://cdn.shopify.com/s/files/1/0057/8938/4802/files/2_a25aff7a-b5c4-4565-a111-6e1ce2d5b5f0.png?v=1624268771',
//                             // 'https://cdn1.ethoswatches.com/media/mobile/new-arrivals/mobile-new-watches-23-04-21.jpg',
//                             cartProduct.imageUrl,
//                           ),
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     height: 100,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           // "tttttttttttttttttttttttttttttttttttfgttfgfgfgtttAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
//                           "${cartProduct.name}",
//                           style: TextStyle(
//                             // fontSize: 16,
//                             fontWeight: FontWeight.normal,
//                             // color: themeChange.darkTheme
//                             //     ? Theme.of(context)
//                             //         .textSelectionTheme
//                             //         .selectionColor
//                             //     : Colors.black87,
//                             color: Colors.black87,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "₹ ${(cartProduct.price * 73).round()}",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w900,
//                             fontSize: 20,
//                             color: themeChange.darkTheme
//                                 ? Theme.of(context).canvasColor
//                                 : Colors.black,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         // SizedBox(
//                         //   height: 5,
//                         // ),
//                         Flexible(
//                           child: Text(
//                             "FREE Shipping",
//                             style: TextStyle(
//                               // fontWeight: FontWeight.w900,
//                               color: themeChange.darkTheme
//                                   ? Theme.of(context).canvasColor
//                                   : Colors.black,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(
//                             // height: 15,
//                             ),
//                         const Flexible(
//                           child: Text(
//                             "In stock",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w900,
//                               color:
//                                   // themeChange.darkTheme
//                                   //     ? Theme.of(context).canvasColor :
//                                   Colors.green,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.95,
//               child: Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       // used padding just for demo purpose to separate from the appbar and the main content
//                       padding: const EdgeInsets.all(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           // color: Colors.black54,
//                           borderRadius: BorderRadius.circular(
//                             // Radius.circular(10),
//                             10.0,
//                           ),
//                           // border: Border.all(
//                           //   width: 1,
//                           // ),
//                         ),
//                         alignment: Alignment.topCenter,
//                         child: Container(
//                             height: 30,
//                             // padding: const EdgeInsets.all(2),
//                             width: MediaQuery.of(context).size.width * 0.3,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade300,
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(10),
//                               ),
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Material(
//                                     borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(40),
//                                       topRight: Radius.circular(40),
//                                     ),
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: cartProduct.quantity < 2
//                                           ? null
//                                           : () {
//                                               cartProvider
//                                                   .reduceProductByOneFromCart(
//                                                 widget.productId,
//                                                 cartProduct.price,
//                                                 cartProduct.name,
//                                                 cartProduct.imageUrl,
//                                               );
//                                             },
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                           color: Colors.transparent,
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(2),
//                                             topLeft: Radius.circular(2),
//                                           ),
//                                         ),
//                                         alignment: Alignment.center,
//                                         child: Icon(Icons.remove,
//                                             color: themeChange.darkTheme
//                                                 ? Theme.of(context).buttonColor
//                                                 : Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       // border: Border.symmetric(
//                                       //   horizontal: BorderSide(
//                                       //     width: 0.5,
//                                       //   ),
//                                       // ),
//                                     ),
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       // "10",
//                                       "${cartProduct.quantity}",
//                                       style: TextStyle(
//                                         // ignore: deprecated_member_use
//                                         color: themeChange.darkTheme
//                                             ? Theme.of(context).buttonColor
//                                             : Colors.black,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Material(
//                                     borderOnForeground: false,
//                                     borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(2),
//                                       topRight: Radius.circular(7),
//                                     ),
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: () {
//                                         cartProvider.addProductToCart(
//                                           widget.productId,
//                                           cartProduct.price,
//                                           cartProduct.name,
//                                           cartProduct.imageUrl,
//                                         );
//                                       },
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                           color: Colors.transparent,
//                                           // borderRadius: BorderRadius.only(
//                                           //   bottomRight: Radius.circular(60),
//                                           //   topRight: Radius.circular(60),
//                                           // ),
//                                         ),
//                                         alignment: Alignment.center,
//                                         child: Icon(Icons.add,
//                                             color: themeChange.darkTheme
//                                                 ? Theme.of(context).buttonColor
//                                                 : Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.005,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.23,
//                       child: TextButton.icon(
//                         onPressed: () {
//                           alertMethod.myShowDialog(
//                             context,
//                             "Remove this item!",
//                             "Are you sure you want to delete ${cartProduct.name} from your cart?",
//                             () {
//                               cartProvider
//                                   .removeProductFromCart(widget.productId);
//                             },
//                           );
//                         },
//                         icon: Icon(Icons.delete,
//                             // color: Colors.grey.shade400,
//                             color: themeChange.darkTheme
//                                 ? Theme.of(context).buttonColor
//                                 : Theme.of(context).accentColor),
//                         label: Text(
//                           'Delete',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               // color: Colors.grey.shade400,
//                               // color: Theme.of(context).buttonColor,
//                               color: themeChange.darkTheme
//                                   ? Theme.of(context).buttonColor
//                                   : Theme.of(context).accentColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.005,
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Save for later",
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );