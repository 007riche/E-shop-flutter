// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/order.dart';
// import 'package:eshop/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrdersFromFirebase() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user = _auth.currentUser;
    var _uid = _user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: _uid)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _orders.clear();
        ordersSnapshot.docs.forEach((element) {
          _orders.insert(
            0,
            Order(
              orderId: element.get("orderId"),
              productId: element.get("productId"),
              userId: element.get("userId"),
              name: element.get("name"),
              imageUrl: element.get("imageUrl"),
              deliveryDate: element.get("deliveryDate"),
              orderDate: element.get("orderDate"),
              paymentMethod: element.get("paymentMethod"),
              price: (element.get("price") * 73)
                  .toString(), //(int.parse(element.get("price")) * 73).toString(),
              quantity: element.get("quantity").toString(),
              reviewRate: element.get("reviewRate"),
              shippingAddress: element.get("shippingAddress"),
              status: element.get("status"),
              total: element.get("total").toString(),
            ),
          );
        });
      });
    } catch (error) {}
    print(_orders);
    notifyListeners();
  }
}
