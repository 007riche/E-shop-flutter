import 'package:eshop/models/wishlist_product.dart';
import 'package:flutter/foundation.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListProduct> _wishListItems = {};
  Map<String, WishListProduct> get getWishListItems {
    return {..._wishListItems};
  }

  void addAndRemoveProductToWishList(
      String productId, double price, String name, String imageUrl) {
    if (_wishListItems.containsKey(productId)) {
      removeProductFromWishList(productId);
    } else {
      _wishListItems.putIfAbsent(
          productId,
          () => WishListProduct(
                id: DateTime.now().toString(),
                name: name,
                price: price,
                imageUrl: imageUrl,
              ));
    }
    notifyListeners();
  }

  void removeProductFromWishList(String productId) {
    _wishListItems.remove(productId);
    notifyListeners();
  }

  void clearEntireWishList() {
    _wishListItems.clear();
    notifyListeners();
  }
}
