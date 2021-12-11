import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Order with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String name;
  final String price;
  final String total;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;
  final String status;
  final String reviewRate;
  final String paymentMethod;
  final Timestamp deliveryDate;
  final String shippingAddress;

  Order(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.name,
      required this.price,
      required this.total,
      required this.imageUrl,
      required this.quantity,
      required this.orderDate,
      required this.status,
      required this.reviewRate,
      required this.paymentMethod,
      required this.deliveryDate,
      required this.shippingAddress});
}
