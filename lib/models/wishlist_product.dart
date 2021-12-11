import 'package:flutter/material.dart';

class WishListProduct with ChangeNotifier {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  WishListProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
