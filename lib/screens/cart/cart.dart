// ignore_for_file: prefer_const_constructors

// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/screens/cart/widgets/cart_empty.dart';
import 'package:eshop/screens/cart/widgets/cart_full.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:eshop/services/payments_processing/stripe/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/Cart-screen";

  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    StripeService.init();
    super.initState();
  }

  var response;
  Future<void> payWithStripe(int amount) async {
    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    _dialog.show(
      message: "Processing the ransaction ",
      type: SimpleFontelicoProgressDialogType.hurricane,
    );
    response = await StripeService.paymentWithNewCard(
      currency: "INR",
      amount: amount.toString(),
    );
    _dialog.hide();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message,
        ),
        duration: Duration(
          seconds: response.success == true ? 3 : 5,
        ),
      ),
    );
    print(response.message);
  }

  GlobalAlertMethod alertMethod = GlobalAlertMethod();
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // List products = []; // Fromerly used for building the cart screen
    final cartProvider = Provider.of<CartProvider>(context);
    int itemsQuantity = 0;
    cartProvider.getCartItems.forEach((key, value) {
      itemsQuantity += value.quantity;
    });

    return cartProvider.getCartItems.isEmpty
        ? SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: const [
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: null,
                    icon: Icon(
                      AppIcons.trashDisabled,
                      size: 32,
                    ),
                  )
                ],
                title: Text(
                  " My Cart",
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
              body: EmptyCart(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Theme.of(context).accentColor,
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {
                        alertMethod.myShowDialog(
                          context,
                          "Clear your shopping cart",
                          "This action will clear Your entire shopping. Are you sure you want to proceed?",
                          () => cartProvider.clearEntireCart(),
                        );
                      },
                      icon: Icon(
                        AppIcons.trash,
                      ),
                    ),
                  ),
                ],
                title: Text(
                  " My Cart: ($itemsQuantity) Items",
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
              bottomSheet: checkOutSection(context, themeChange, itemsQuantity,
                  (cartProvider.totalCartAmount * 73).ceil()),
              body: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                ),
                child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext localCtx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: FullCart(
                        // id: cartProvider.getCartItems.values.toList()[index].id,
                        // imageUrl: cartProvider.getCartItems.values
                        //     .toList()[index]
                        //     .imageUrl,
                        // name:
                        //     cartProvider.getCartItems.values.toList()[index].name,
                        // price: cartProvider.getCartItems.values
                        //     .toList()[index]
                        //     .price,
                        productId: cartProvider.getCartItems.keys.toList()[
                            index], // Also usable with the former approach
                        // quantity: cartProvider.getCartItems.values
                        //     .toList()[index]
                        //     .quantity,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }

  Widget checkOutSection(BuildContext context, DarkThemeProvider themeProvider,
      int itemsQuantity, int total) {
    final cartProvider = Provider.of<CartProvider>(context);
    var uuid = Uuid();
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03,
        ),
        decoration: BoxDecoration(
            // color: Colors.blue,
            ),
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products Quantity:",
                    ),
                    Text(
                      itemsQuantity.toString(),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
              height: 2,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "INR $total ₹",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: () async {
                  await payWithStripe(total);
                  if (response.success == true) {
                    final orderId = uuid.v4();
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    User? user = _auth.currentUser;
                    final _uid = user!.uid;
                    cartProvider.getCartItems.forEach((key, orderValue) async {
                      final orderId = uuid.v4();
                      try {
                        await FirebaseFirestore.instance
                            .collection("orders")
                            .doc(orderId)
                            .set({
                          "orderId": orderId,
                          "userId": _uid,
                          "productId": orderValue.productId,
                          "name": orderValue.name,
                          "price": orderValue.price,
                          "total": orderValue.price * orderValue.quantity,
                          "imageUrl": orderValue.imageUrl,
                          "quantity": orderValue.quantity,
                          "orderDate": Timestamp.now(),
                          "status": "Ordered",
                          "reviewRate": "0",
                          "paymentMethod": "Stripe payment",
                          "deliveryDate": DateTime.now().add(Duration(days: 7)),
                          "shippingAddress": "",
                        }).then((value) => cartProvider.clearEntireCart());
                      } catch (error) {
                        print("Occured error $error");
                      }
                    });
                  } else {
                    alertMethod.authErrorHandlingDialog(
                        context: context,
                        subTitle:
                            "Transaction failed! Please, provide correctly your payment credentials.");
                  }
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: themeProvider.darkTheme
                        ? Theme.of(context).accentColor
                        : Colors.amberAccent,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      "Proceed to Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
