// ignore_for_file: prefer_const_constructors

import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/orders_provider.dart';
import 'package:eshop/screens/cart/widgets/cart_empty.dart';
import 'package:eshop/screens/cart/widgets/cart_full.dart';
import 'package:eshop/screens/orders/widgets/empty_user_orders.dart';
import 'package:eshop/screens/orders/widgets/user_orders_full.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:eshop/services/payments_processing/stripe/payment.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class UserOrdersScreen extends StatefulWidget {
  static const routeName = "/Order-screen";

  const UserOrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  @override
  void initState() {
    StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // List products = []; // Fromerly used for building the cart screen
    // final cartProvider = Provider.of<CartProvider>(context);
    final orderstProvider = Provider.of<OrdersProvider>(context);
    // int itemsQuantity = 0;
    // cartProvider.getCartItems.forEach((key, value) {
    //   itemsQuantity += value.quantity;
    // });
    GlobalAlertMethod alertMethod = GlobalAlertMethod();

    return FutureBuilder(
      future: orderstProvider.fetchOrdersFromFirebase(),
      builder: (context, snapshot) {
        return orderstProvider.getOrders.isEmpty
            ? SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      " My Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  body: UserEmptyOrders(),
                ),
              )
            : SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        " My orders",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    body: Container(
                      // margin: EdgeInsets.only(
                      //   bottom: MediaQuery.of(context).size.height * 0.25,
                      // ),
                      child: ListView.builder(
                        itemCount: orderstProvider.getOrders.length,
                        itemBuilder: (BuildContext localCtx, int index) {
                          return ChangeNotifierProvider.value(
                              value: orderstProvider.getOrders[index],
                              child: UserOrdersFull());
                        },
                      ),
                    )
                    // },
                    ),
                // ),
              );
      },
    );
  }
}
