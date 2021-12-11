import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/consts/colors.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/provider/wishlist_provider.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:eshop/widget/feed_product_widget.dart';
// import 'package:eshop/widget/feed_product_widget.dart';
import 'package:eshop/widget/popular_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'Product_details';
  final List<String>? imageUrl;
  final String? name;
  final String? description;
  final double? price;

  const ProductDetails({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];

  final CarouselController _carousel_controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.products;
    final String productIdRouteArgs =
        ModalRoute.of(context)!.settings.arguments.toString();
    // print("productIdRouteArgs $productIdRouteArgs");
    final productOfThePage = productsData.findProductById(productIdRouteArgs);
    final List<String>? productImgList = productOfThePage.imageUrl;
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 16,
                        ),
                        Text("Deliver to Rick - shimla"),
                        Icon(
                          Icons.expand_more,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brand : ${productOfThePage.brandName}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.indigo,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 7,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "500",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                child: Text(
                  // "data nlnlnlnononfsdon noin oion ofvlkn nflk nldfkn lknfs nk lvdfnvonovin ldkfnl ndfvsinoi ndovfn dknfs lkndvflskn lkdsnf vninosnvo snonvo ndosvf odn oisdnv osinv lnvio noivnivni nvdinvdlfvnl dkvnlskvn lkn vlkn vlknv ldkfsvlk ldkldfsldf nvldkvn ldvn flvk ldskv ldkv ldkvn "
                  // .trim(),
                  "",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 7,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CarouselSlider.builder(
                          carouselController: _carousel_controller,
                          itemCount: productImgList!.length,
                          options: CarouselOptions(
                            enableInfiniteScroll:
                                productImgList.length == 1 ? false : true,
                            viewportFraction: 1,
                            height: MediaQuery.of(context).size.height * 0.3,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: EdgeInsets.symmetric(
                                horizontal: 7,
                              ),
                              child: Center(
                                child: Image.network(productImgList[index],
                                    fit: BoxFit.contain, width: 1000),
                              ),
                            );
                          },
                        ),
                        if (productImgList.length > 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                productImgList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _carousel_controller
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.only(
                                    top: 20.0,
                                    left: 7.0,
                                    right: 7.0,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.5
                                              : 0.2)),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                    Positioned(
                      top: 10,
                      right: 25,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0x99ffffff),
                        ),
                        child: Center(
                          child: Icon(
                            AppIcons.share,
                            size: 20,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 25,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0x99ffffff),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              wishListProvider.addAndRemoveProductToWishList(
                                productIdRouteArgs,
                                productOfThePage.price!,
                                productOfThePage.name,
                                productOfThePage.imageUrl![0],
                              );
                            },
                            icon: Icon(
                              wishListProvider.getWishListItems
                                      .containsKey(productIdRouteArgs)
                                  ? AppIcons.wishlistSelect
                                  : AppIcons.wishlist,
                              size: 20,
                              color: wishListProvider.getWishListItems
                                      .containsKey(productIdRouteArgs)
                                  ? Colors.red.shade900
                                  : Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "₹",
                      style: TextStyle(
                        fontFeatures: [FontFeature.superscripts()],
                      ),
                    ),
                    Text(
                      "${(productOfThePage.price! * 73.0).round()}",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), // stock and buy
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                // height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "FREE delivery: ",
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            "Tuesday, Dec 7",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: productOfThePage.quantity! <= 0
                          ? Text(
                              "Out Of Stock",
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            )
                          : productOfThePage.quantity! > 10
                              ? Text(
                                  "In stock",
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                  ),
                                )
                              : Text(
                                  "Only ${productOfThePage.quantity} left!",
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                    ),
                    InkWell(
                      // highlightColor: Colors.red,
                      // splashColor: Colors.red,
                      onTap: () {},
                      child: Expanded(
                        child: Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Colors.orange,
                          ),
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 7.0,
                            ),
                            child: Text(
                              "Buy Now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                // fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    InkWell(
                      highlightColor:
                          Colors.grey.shade900, // Colors.transparent,
                      splashColor: Colors.grey.shade900,

                      onTap: cartProvider.getCartItems
                              .containsKey(productIdRouteArgs)
                          ? () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            }
                          : () {
                              cartProvider.getCartItems
                                      .containsKey(productIdRouteArgs)
                                  ? null
                                  : cartProvider.addProductToCart(
                                      productIdRouteArgs,
                                      productOfThePage.price!,
                                      productOfThePage.name,
                                      productOfThePage.imageUrl![0],
                                    );
                            },
                      child: Expanded(
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Colors.amberAccent,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 7.0,
                            ),
                            child: Text(
                              cartProvider.getCartItems
                                      .containsKey(productIdRouteArgs)
                                  ? "Go To Cart"
                                  : "Add to Cart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                // fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: TextButton(
                        onPressed: () {
                          wishListProvider.addAndRemoveProductToWishList(
                            productIdRouteArgs,
                            productOfThePage.price!,
                            productOfThePage.name,
                            productOfThePage.imageUrl![0],
                          );
                        },
                        child: const Text(
                          "ADD TO WISHLIST",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Details
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), //
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    _detailsTable(
                        "Brand::  BrandName \nQuantity:: 12  Left \nCategory:: Cat Name \nPopularity::Popular"),
                  ],
                ),
              ), //Description
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), //
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      // "Details ofslnlfslnkln sihil hsfijsfo lsifhl lsfihlhisflihlsf lisfh lihflhlishf lfsifl hlisf hlhisflh lsfhlisfl lfhls hflsflhslfilsnlfgiuailkubfguipbgabfgab ;uagibuifdgba i fiuad uigb afbug iubfd gibadlib aibugdf ub. \nDetails ofslnlfslnkln sihil hsfijsfo lsifhl lsfihlhisflihlsf lisfh lihflhlishf lfsifl hlisf hlhisflh lsfhlisfl lfhls hflsflhslfilsnlfgiuailkubfguipbgabfgab ;uagibuifdgba i fiuad uigb afbug iubfd gibadlib aibugdf ub",
                      "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ), // Features
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), //
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Text(
                    "Customer Question",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ), // customer questions
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), //
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Text(
                    "Custome Review",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ), // customer reviews
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ), //
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: Text(
                        "Trending Popular products",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 30,
                      ),
                      width: double.infinity,
                      height: 300,
                      child: ListView.builder(
                        itemCount: products.length < 10 ? products.length : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                            value: products[index],
                            child: Container(
                              child: PopularProduct(
                                  // imageUrl: widget.imageUrl,
                                  // name: widget.name,
                                  // description: widget.description,
                                  // price: widget.price,
                                  ),
                              margin: EdgeInsets.only(
                                left: 7,
                                right: 7,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ), // You may like
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: Text(
                        "You might also like",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 30,
                      ),
                      width: double.infinity,
                      height: 300,
                      child: ListView.builder(
                        itemCount: products.length < 10 ? products.length : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                            value: products[index],
                            child: Container(
                              child: FeedProduct(
                                  // imageUrl: widget.imageUrl,
                                  // name: widget.name,
                                  // description: widget.description,
                                  // price: widget.price,
                                  ),
                              margin: EdgeInsets.only(
                                left: 7,
                                right: 7,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//

  Widget _detailsTable(String info) {
    List<String> characte = info.split("\n");
    List<TableRow> rows = [];
    for (var charac in characte) {
      // print(charac);
      List<String> entry = charac.split("::");
      print(entry);
      // for () {
      rows.add(
        TableRow(
          children: [
            Text(
              entry[0],
              style: TextStyle(
                color: Colors.grey.shade500,
                height: 2.5,
              ),
            ),
            Text(
              entry[1],
              style: TextStyle(
                color: Colors.grey.shade800,
                height: 2.5,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Table(
        // textBaseline: ,
        textDirection: TextDirection.ltr,
        children: rows,
      ),
    );
  }
}
