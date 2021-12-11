import 'package:eshop/models/product.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brands_rail_widget.dart';

Set<String> selectedBrands = {};

class BrandNavigationScreen extends StatefulWidget {
  const BrandNavigationScreen({Key? key}) : super(key: key);
  static const routeName = '/brand_navigation';

  @override
  _BrandNavigationScreenState createState() => _BrandNavigationScreenState();
}

class _BrandNavigationScreenState extends State<BrandNavigationScreen> {
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
  final List _brands_name = [
    "All",
    "Acer",
    "Apple",
    "Dell",
    "H&M",
    "HP",
    "Huawei",
    "Nike",
    "Oppo",
    "Samsung",
  ];
  int _selectedIndex = 0;
  String routeArgs = "";
  String brand = "";
  // List<String> selectedBrands = [];

  final ScrollController _controller = ScrollController();
  final double _height = 75;
  _animateToIndex(i) => _controller.animateTo(_height * i,
      duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'Acer';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Apple';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Dell';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'H&M';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'HP';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Huawei';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Nike';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'Oppo';
      });
    }
    if (_selectedIndex == 8) {
      setState(() {
        brand = 'Samsung';
      });
    }

    if (_selectedIndex == 9) {
      setState(() {
        brand = 'All';
      });
    }
    selectedBrands.add(brand);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Navigator.pop(context);
    setState(() {
      selectedBrands = {};
    });
    selectedBrands;

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final productFilteredBrands = productData.findByBrand(selectedBrands);
    if (brand == "All") {
      for (int i = 0; i < productData.products.length; i++) {
        productFilteredBrands!.add(productData.products[i]);
      }
    }
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _animateToIndex(8),
        //   child: Icon(Icons.arrow_right_alt),
        // ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: _brands_images.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return BrandButtonFilter(
                    selectedIndex: _selectedIndex,
                    selected: false,
                    index: index,
                    brandName: _brands_name[index],
                    selectedBrands: selectedBrands,
                  );
                },
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.85,
                // margin: EdgeInsets.only(
                //   bottom: 20,
                // ),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 7, 0, 0),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                        itemCount: productFilteredBrands!.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ChangeNotifierProvider.value(
                          value: productFilteredBrands[index],
                          child: BrandsNavigationRail(),
                        ),
                      ),
                    ),
                  ),
                )
                // ContentSpace(context, selectedBrands),
                ),
          ],
        ),
      ),
    );
  }
}

class ContentSpace extends StatefulWidget {
  // final int _selectedIndex;

  final Set<String> brand;
  // ignore: use_key_in_widget_constructors
  const ContentSpace(BuildContext context, this.brand);

  @override
  State<ContentSpace> createState() => _ContentSpaceState();
}

class _ContentSpaceState extends State<ContentSpace> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final productFilteredBrands = productData.findByBrand(selectedBrands);
    // final productFilteredBrands = productData.filteredBrand;
    // print("${productFilteredBrands!.length} products filtered");
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 7, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: productFilteredBrands!.length,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
              value: productFilteredBrands[index],
              child: BrandsNavigationRail(),
            ),
          ),
        ),
      ),
    );
  }
}

class BrandButtonFilter extends StatefulWidget {
  // const BrandButtonFilter({Key? key}) : super(key: key);
  bool _selected = false;
  // final Function(int) activateScroll;
  final int selectedIndex;
  final bool selected;
  final int index;
  final String brandName;
  Set<String> selectedBrands;

  BrandButtonFilter({
    Key? key,
    required this.selectedBrands,
    // required this.activateScroll,
    required this.selectedIndex,
    required this.selected,
    required this.index,
    required this.brandName,
  }) : super(key: key);

  @override
  _BrandButtonFilterState createState() => _BrandButtonFilterState();
}

class _BrandButtonFilterState extends State<BrandButtonFilter> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    int selected = widget.selectedIndex == 9 ? 0 : widget.selectedIndex + 1;
    // List<String> selectedBrands = [];
    // final productFilteredBrands = ;
    return InkWell(
      onTap: widget.selected == widget.selectedIndex
          ? () {
              print(selectedBrands);
            }
          : null,
      // () {
      //   setState(
      //     () {
      //       // if (selected != 0) {
      //       //   // ;
      //       // }
      //       // widget._selected = !widget._selected;
      //       // if (widget._selected) {
      //       //   selectedBrands.add(
      //       //     widget.brandName,
      //       //   );
      //       // } else {
      //       //   selectedBrands
      //       //       .removeWhere((element) => element == widget.brandName);
      //       // }
      //       // productData.findByBrand(widget.selectedBrands);
      //       print(selectedBrands);
      //       print(widget.index);
      //       print(widget._selected);
      //     },
      //   );
      // },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 75,
          maxHeight: MediaQuery.of(context).size.height * 0.025,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 2.5, 25, 0),
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          child: Text(
            widget.brandName,
            // _brands_name[index],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget._selected || (selected == widget.index)
                  ? Colors.amber
                  : Theme.of(context).textSelectionColor,
              width: 2,
            ),
            color: widget._selected || (selected == widget.index)
                ? Colors.amber
                : Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.025),
          ),
        ),
      ),
    );
  }
}
