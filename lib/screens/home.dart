// ignore_for_file: prefer_const_constructors

import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/inner_screens/brand_navigation_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/screens/feeds.dart';
import 'package:eshop/screens/search.dart';
import 'package:eshop/widget/backlayer.dart';
import 'package:eshop/widget/category.dart';
import 'package:eshop/widget/popular_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _carousel_images = [
    "assets/images/banner/discount_on_mobile_phones.png",
    "assets/images/banner/discount.jpeg",
    "assets/images/banner/earbud.jpeg",
    "assets/images/banner/fourniture.jpg",
    "assets/images/banner/headset.png",
    "assets/images/banner/iPhone13Pro.jpeg",
    "assets/images/banner/oneplus.jpg",
    "assets/images/banner/oppo.jpg",
    "assets/images/banner/pc.jpeg",
  ];

  final List _brands_images = [
    "assets/images/brands/Acer.png",
    "assets/images/brands/Apple.png",
    "assets/images/brands/Dell.png",
    "assets/images/brands/HM.png",
    "assets/images/brands/HP.jpg",
    "assets/images/brands/Huawei.png",
    "assets/images/brands/nike.png",
    "assets/images/brands/Oppo.png",
    "assets/images/brands/samsung.jpg",
  ];

  TextEditingController _searchTextController = TextEditingController();
  final FocusNode _node = FocusNode();
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<Product> _searchList = [];
  bool hasSearch = false;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    productData.fetchProductsFromFirebase();
    final popularProductList = productData.popularProducts;
    return Scaffold(
      body: BackdropScaffold(
        appBar: BackdropAppBar(
          automaticallyImplyLeading: false,
          leading: BackdropToggleButton(
            icon: AnimatedIcons.close_menu,
            color: Theme.of(context).textSelectionColor,
          ),
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).appBarTheme.color,
          //   ),
          // ),
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            // margin: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchTextController,
              minLines: 1,
              focusNode: _node,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: 'I am looking for ...',
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                suffixIcon: IconButton(
                  onPressed: _searchTextController.text.isEmpty
                      ? () {
                          hasSearch = false;
                          _node.unfocus();
                        }
                      : () {
                          hasSearch = false;
                          _searchTextController.clear();
                          _node.unfocus();
                        },
                  icon: _searchTextController.text.isEmpty
                      ? Icon(
                          AppIcons.backPage,
                          color:
                              //  _searchTextController.text.isNotEmpty
                              //     ? Colors.red
                              //     :
                              Colors.grey,
                        )
                      : Icon(Feather.x,
                          color:
                              // _searchTextController.text.isNotEmpty
                              //     ?
                              Colors.red
                          // : Colors.grey
                          ),
                ),
              ),
              onChanged: (value) {
                _searchTextController.text.toLowerCase();
                setState(() {
                  _searchList = productData.searchProductQuery(value)!;
                  print(_searchList);
                });
              },
            ),
          ),

          // Text(
          //   "Home",
          //   style: TextStyle(
          //       // color: Colors.black,
          //       ),
          // ),
          actions: const <Widget>[],
        ),
        backLayer: BackLayerMenu(),
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        frontLayer: !hasSearch && _searchTextController.text.isEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      child: Carousel(
                        // dotSpacing: 50.0,
                        radius: Radius.circular(30.0),
                        boxFit: BoxFit.fitWidth,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1000),
                        dotSize: 5.0,
                        dotIncreasedColor: Color(0xFFFF335C),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: List.generate(
                          _carousel_images.length,
                          (index) => Image.asset(
                            _carousel_images[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        // _carousel_images
                        //     .map((intindex) => Image.network(_carousel_images[index]))
                        //     .toList(),
                        //             [
                        // _carousel_images.map((index) => Image.network( _carousel_images[index] )).toList(),

                        //               // List.generate( _carousel_images.length, (index) => Image.network( _carousel_images[index] )),
                        //               // Image.network(
                        //               //     "'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'"),
                        //               Image.network(
                        //                   "https://cdn.mos.cms.futurecdn.net/Nxz3xSGwyGMaziCwiAC5WW-1024-80.jpg"),
                        //               Image.network("https://wallpaperaccess.com/full/19921.jpg"),
                        //               Image.network(
                        //                 "https://images.pexels.com/photos/2635817/pexels-photo-2635817.jpeg?auto=compress&crop=focalpoint&cs=tinysrgb&fit=crop&fp-y=0.6&h=500&sharp=20&w=1400",
                        //               ),
                        //             ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 12,
                          itemBuilder: (BuildContext ctx, int index) {
                            return CategoryWidget(
                              index: index,
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Popular Brands",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                BrandNavigationScreen.routeName,
                                arguments: {
                                  9,
                                },
                              );
                            },
                            child: Text(
                              "View more...",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Swiper(
                        itemCount: _brands_images.length,
                        autoplay: true,
                        viewportFraction: 0.8,
                        scale: 0.9,
                        onTap: (index) {
                          Navigator.of(context).pushNamed(
                            BrandNavigationScreen.routeName,
                            arguments: {
                              index,
                            },
                          );
                        },
                        itemBuilder: (BuildContext local_context, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                _brands_images[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Popular Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                FeedsScreen.routeName,
                                arguments: "popular",
                              );
                            },
                            child: Text(
                              "View more...",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 285,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: ListView.builder(
                        itemCount: popularProductList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                            value: popularProductList[index],
                            child: PopularProduct(
                                // imageUrl: popularProductList[index].imageUrl![0],
                                // name: popularProductList[index].name,
                                // description: popularProductList[index].description!,
                                // price: popularProductList[index].price!,
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : SearchScreen(
                searchList: _searchList,
              ),
      ),
    );
  }
}
