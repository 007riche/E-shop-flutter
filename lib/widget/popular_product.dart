import 'package:eshop/consts/icons.dart';
import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

class PopularProduct extends StatelessWidget {
  // final String imageUrl;
  // final String name;
  // final String description;
  // final double price;

  // const PopularProduct({
  //   Key? key,
  //   required this.imageUrl,
  //   required this.name,
  //   required this.description,
  //   required this.price,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetails.routeName,
                  arguments: productAttributes.id
                  // [
                  //   productAttributes.imageUrl,
                  //   productAttributes.name,
                  //   productAttributes.description,
                  //   productAttributes.price,
                  // ],
                  );
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            // 'https://cdn1.ethoswatches.com/media/mobile/new-arrivals/mobile-new-watches-23-04-21.jpg',
                            productAttributes.imageUrl![0],
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 12,
                      child: wishListProvider.getWishListItems
                              .containsKey(productAttributes.id)
                          ? Icon(
                              AppIcons.wishlistSelect,
                              // Entypo.star_outlined,
                              color: Colors.red.shade600,
                            )
                          : Icon(
                              AppIcons.wishlist,
                              // Entypo.star_outlined,
                              color: Colors.grey.shade600,
                            ),
                    ),
                    Positioned(
                      bottom: 32,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          "₹ ${(productAttributes.price! * 73).round()}",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "Item Name",
                        productAttributes.name,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      // Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              // "Description",
                              productAttributes.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: cartProvider.getCartItems
                                        .containsKey(productAttributes.id)
                                    ? () {
                                        Navigator.of(context)
                                            .pushNamed(CartScreen.routeName);
                                      }
                                    : () {
                                        cartProvider.getCartItems.containsKey(
                                                productAttributes.id)
                                            ? null
                                            : cartProvider.addProductToCart(
                                                productAttributes.id!,
                                                productAttributes.price!,
                                                productAttributes.name,
                                                productAttributes.imageUrl![0],
                                              );
                                      },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    cartProvider.getCartItems
                                            .containsKey(productAttributes.id!)
                                        ? AppIcons.cartAdded
                                        : AppIcons.cartAdd,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
