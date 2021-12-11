import 'package:eshop/models/cart_product.dart';

import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartProduct> _cartItems = {};
  Map<String, CartProduct> get getCartItems {
    return {..._cartItems};
  }

  double get totalCartAmount {
    double total = 0.0;
    _cartItems.forEach((key, product) {
      total += product.price * product.quantity;
    });
    return total;
  }

  void addProductToCart(
      String productId, double price, String name, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartProduct) => CartProduct(
                id: existingCartProduct.id,
                productId: existingCartProduct.productId,
                name: existingCartProduct.name,
                price: existingCartProduct.price,
                imageUrl: existingCartProduct.imageUrl,
                quantity: existingCartProduct.quantity + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartProduct(
                id: DateTime.now().toString(),
                productId: productId,
                name: name,
                price: price,
                imageUrl: imageUrl,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void reduceProductByOneFromCart(
      String productId, double price, String name, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartProduct) => CartProduct(
                id: existingCartProduct.id,
                productId: existingCartProduct.productId,
                name: existingCartProduct.name,
                price: existingCartProduct.price,
                imageUrl: existingCartProduct.imageUrl,
                quantity: existingCartProduct.quantity - 1,
              ));
    }
    notifyListeners();
  }

  void removeProductFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearEntireCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
