// ignore_for_file: prefer_const_constructors

// import 'package:eshop/models/product.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/widget/feed_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  CategoriesFeedsScreen({Key? key}) : super(key: key);
  static const routeName = "/categories-feeds-screen";

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final products = productsProvider.findByCategory(categoryName);

    print("CategoryName passed: " + "\'$categoryName'");
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: products!.length,
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              value: products[index],
              child: FeedProduct(
                  // name: products[index].name,
                  // description: products[index].description,
                  // price: products[index].price,
                  // imageUrl: [products[index].imageUrl![0]],
                  // quantity: products[index].quantity,
                  // isUserFavorite: products[index].isUserFavorite,
                  ),
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
          ),
    );
  }
}
