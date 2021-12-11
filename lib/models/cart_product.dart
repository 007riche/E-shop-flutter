import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct with ChangeNotifier {
  final String id;
  final String name;
  final String productId;
  final int quantity;
  final double price;
  final String imageUrl;

  CartProduct({
    required this.id,
    required this.name,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  // CartProduct({
  //   required this.id,
  //   required this.name,
  //   required this.quantity,
  //   required this.price,
  //   required this.imageUrl,
  // });
}
