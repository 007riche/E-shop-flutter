// ignore_for_file: prefer_const_constructors

// import 'package:eshop/models/product.dart';
import 'package:badges/badges.dart';
import 'package:eshop/consts/colors.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:eshop/screens/wishlist/wishlist_screen.dart';
import 'package:eshop/widget/feed_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  static const routeName = "/feeds-screen";

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> products = productsProvider.feedsproducts;
    // ignore: unnecessary_null_comparison
    // if (popular == Null) {
    // products = productsProvider.feedsproducts;
    // }
    if (popular == 'popular') {
      products = productsProvider.popularProducts;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Feeds'),
          actions: [
            Consumer<WishListProvider>(
              builder: (_, favs, ch) => Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  favs.getWishListItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    AppIcons.wishlist,
                    color: ColorsConsts.favColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (_, cart, ch) => Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  cart.getCartItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    AppIcons.cart,
                    color: ColorsConsts.cartColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider.value(
                value: products[index],
                child: products[index].quantity! > 0
                    ? FeedProduct(
                        // name: products[index].name,
                        // description: products[index].description,
                        // price: products[index].price,
                        // imageUrl: [products[index].imageUrl![0]],
                        // quantity: products[index].quantity,
                        // isUserFavorite: products[index].isUserFavorite,
                        )
                    : null,
              );
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 2.65 : 2.8),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 6.0,
          ),
        )
        // GridView.count(
        //   crossAxisCount: 2,
        //   crossAxisSpacing: 3,
        //   mainAxisSpacing: 5,
        //   childAspectRatio: 2 / 2.75,
        //   children: List.generate(100, (index) {
        //     return FeedProduct();
        //   }),
        // ),
        );
  }
}
