import 'package:eshop/consts/colors.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;

  const FeedDialog({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final productOfThePage = productsData.findProductById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Image.network(
              // 'https://images-na.ssl-images-amazon.com/images/I/61utX8kBDlL.jpg',
              productOfThePage.imageUrl![0],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(context, 0, () {}),
                  ),
                  Flexible(
                    child: dialogContent(context, 1, () {
                      Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: productOfThePage.id)
                          .then((value) => Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null);
                    }),
                  ),
                  Flexible(
                    child: dialogContent(
                        context,
                        2,
                        cartProvider.getCartItems.containsKey(productId)
                            ? () {}
                            : () {}
                        // : () {
                        //     cartProvider.addProductToCart(
                        //         productId,
                        //         productOfThePage.price!,
                        //         productOfThePage.name,
                        //         productOfThePage.imageUrl![0]);
                        //   },
                        ),
                  ),
                ]),
          ),

          /************close****************/
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                shape: BoxShape.circle),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function fct) {
    final cart = Provider.of<CartProvider>(context);
    final favs = Provider.of<WishListProvider>(context);
    List<IconData> _dialogIcons = [
      favs.getWishListItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      AppIcons.eye,
      AppIcons.cart,
      // AppIcons.trash,
    ];

    List<String> _texts = [
      favs.getWishListItems.containsKey(productId)
          ? 'In wishlist'
          : 'Add to wishlist',
      'View product',
      cart.getCartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color> _colors = [
      favs.getWishListItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
    ];
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct(),
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //  fontSize: 15,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : ColorsConsts.subTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
