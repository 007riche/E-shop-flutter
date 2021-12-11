// ignore_for_file: prefer_const_constructors

import 'package:eshop/models/product.dart';
import 'package:eshop/widget/feed_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> searchList;

  const SearchScreen({
    Key? key,
    required this.searchList,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.searchList.isEmpty
          ? Column(
              children: const [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Icon(
                    Feather.search,
                    size: 60,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )
          : GridView.count(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 240 / 420,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(widget.searchList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: widget.searchList[index],
                  child: FeedProduct(),
                );
              }),
            ),
    );
  }
}
