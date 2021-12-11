import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String? id;
  final String name;
  final String? shortOverview;
  final String? description;
  final double? price;
  final List<String>? imageUrl;
  final List<String>? productCategories;
  final String? brandName;
  final int? quantity;
  final bool? isUserFavorite;
  final bool? isPopular;
  final double? reviewRate;
  final List<Map<double, String>>? customersReview;
  final String? details;

  Product({
    this.id,
    required this.name,
    this.shortOverview,
    this.description,
    this.price,
    this.imageUrl,
    this.productCategories,
    this.brandName,
    this.quantity,
    this.isUserFavorite,
    this.isPopular,
    this.reviewRate,
    this.customersReview,
    this.details,
  });
}
