// ignore_for_file: prefer_const_constructors

import 'package:eshop/consts/icons.dart';
import 'package:eshop/inner_screens/product_details_screen.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:eshop/screens/feeds.dart';
import 'package:eshop/screens/home.dart';
import 'package:eshop/screens/search.dart';
import 'package:eshop/screens/user/user.dart';
import 'package:flutter/material.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedIndex = 0;

// List _pages = [
//   HomeScreen(),
// FeedsScreen(),
// SearchScreen(),
// CartScreen(),
// UserScreen(),
// ];

  @override
  void initState() {
    _pages = [
      {
        "page": HomeScreen(),
        "title": "Home Screen",
      },
      {
        "page": FeedsScreen(),
        "title": "Feeds Screen",
      },
      // {
      //   "page": SearchScreen(),
      //   "title": "Search Screen",
      // },
      {
        "page": CartScreen(), // ProductDetails(),
        "title": "Cart Screen",
      },
      {
        "page": UserScreen(),
        "title": "User Screen",
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]["title"]),
      //   centerTitle: true,
      // ),
      body: _pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0.0,
        // elevation: 7,
        clipBehavior: Clip.hardEdge,
        shape: CircularNotchedRectangle(),
        // ignore: prefer_const_literals_to_create_immutables
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border(
                // top: BorderSide(width: 30),
                // left: BorderSide(width: 30),
                // bottom: BorderSide(width: 30),
                // right: BorderSide(width: 30),
                ),
          ),
          child: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(AppIcons.home),
                activeIcon: Icon(AppIcons.homeSelect),
                tooltip: "Home",
                label: "Home",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  AppIcons.feedsSelect,
                ),
                icon: Icon(AppIcons.feeds),
                tooltip: "Feeds",
                label: "Feeds",
              ),
              // BottomNavigationBarItem(
              //   activeIcon: null,
              //   icon: Icon(null),
              //   // icon: Icon(Icons.search),
              //   tooltip: "Search",
              //   label: "",
              // ),
              BottomNavigationBarItem(
                activeIcon: Icon(AppIcons.selectedShoppingBag),
                icon: Icon(AppIcons.shoppingBag),
                tooltip: "Cart",
                label: "Cart",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(AppIcons.userSelect),
                icon: Icon(AppIcons.user),
                tooltip: "User",
                label: "User",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _selectedPage,
            // ignore: deprecated_member_use
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor:
                themeChange.darkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //     hoverElevation: 50,
      //     child: Icon(
      //       Icons.search,
      //     ),
      //     elevation: 7,
      //     tooltip: "Search",
      //     onPressed: () {
      //       setState(() {
      //         _selectedIndex = 2;
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
