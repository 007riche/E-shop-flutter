import 'package:eshop/inner_screens/categories_feeds.dart';

import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final List<Map<String, dynamic>> _categories_images = [
    {
      "categoryName": "Appliances",
      "categoryBannerImagePath": "assets/images/categories/appliance.jpg",
    },
    {
      "categoryName": "Electronics",
      "categoryBannerImagePath": "assets/images/categories/electronic.png",
    },
    {
      "categoryName": "Fashion",
      "categoryBannerImagePath": "assets/images/categories/fashion.png",
    },
    {
      "categoryName": "Fitness & Sport",
      "categoryBannerImagePath": "assets/images/categories/fitness.jpg",
    },
    {
      "categoryName": "Footwears",
      "categoryBannerImagePath": "assets/images/categories/footwear.jpg",
    },
    {
      "categoryName": "Furnitures",
      "categoryBannerImagePath": "assets/images/categories/fourniture2.jpg",
    },
    {
      "categoryName": "Beauty & Cosmetics",
      "categoryBannerImagePath": "assets/images/categories/health_beauty.jpg",
    },
    {
      "categoryName": "Foods & Healthcare",
      "categoryBannerImagePath": "assets/images/categories/health_food.jpg",
    },
    {
      "categoryName": "Kitchen",
      "categoryBannerImagePath": "assets/images/categories/kicthen.png",
    },
    {
      "categoryName": "Laptops",
      "categoryBannerImagePath": "assets/images/categories/laptop.png",
    },
    {
      "categoryName": "Phones",
      "categoryBannerImagePath": "assets/images/categories/phones.png",
    },
    {
      "categoryName": "Watches",
      "categoryBannerImagePath": "assets/images/categories/watch_category.png",
    },
// {
//   "categoryName" : "",
//   "categoryBannerImagePath" : "",
// },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              CategoriesFeedsScreen.routeName,
              arguments: "${_categories_images[widget.index]["categoryName"]}",
            );
            print("${_categories_images[widget.index]["categoryName"]}");
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  _categories_images[widget.index]['categoryBannerImagePath'],
                ),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            color: Theme.of(context).backgroundColor,
            child: Text(
              _categories_images[widget.index]['categoryName'],
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
          ),
        ),
      ],
    );
  }
}
