// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/widget/feeds_dialog.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedProduct extends StatefulWidget {
  // final String? id;
  // final String? name;
  // final String? description;
  // final double? price;
  // final List<String>? imageUrl;
  // final int? quantity;
  // final bool? isUserFavorite;

  const FeedProduct({
    Key? key,
    // this.id,
    // @required this.name,
    // @required this.description,
    // @required this.price,
    // @required this.imageUrl,
    // @required this.quantity,
    // @required this.isUserFavorite,
  }) : super(key: key);

  @override
  _FeedProductState createState() => _FeedProductState();
}

class _FeedProductState extends State<FeedProduct> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: productsAttributes.id,
      ),
      child: Container(
        width: 250,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          color: Colors.grey.shade50,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      // minHeight: 75,
                      // minHeight: MediaQuery.of(context).size.height * 0.25,
                      maxHeight: MediaQuery.of(context).size.height * 0.2,
                    ),
                    child: Image.network(
                      // 'https://cdn.shopify.com/s/files/1/0057/8938/4802/files/2_a25aff7a-b5c4-4565-a111-6e1ce2d5b5f0.png?v=1624268771',
                      productsAttributes.imageUrl![0],
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Badge(
                  toAnimate: true,
                  shape: BadgeShape.square,
                  badgeColor: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  badgeContent:
                      Text('New', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(
                left: 5,
                bottom: 2,
                right: 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    // "Description",
                    " ${productsAttributes.description} ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      "₹ ${(productsAttributes.price! * 73).round()}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity: ${productsAttributes.quantity}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Material(
                      //   color: Colors.transparent,
                      //   child: InkWell(
                      //     onTap: () async {
                      //       showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) =>
                      //             ChangeNotifierProvider.value(
                      //           value: productsAttributes,
                      //           child: FeedDialog(
                      //             productId: productsAttributes.id!,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     borderRadius: BorderRadius.circular(18),
                      //     child: Icon(
                      //       Icons.more_horiz,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
