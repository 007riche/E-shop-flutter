// import 'package:flutter/material.dart';

// import 'brands_rail_widget.dart';

// class BrandNavigationScreen extends StatefulWidget {
//   const BrandNavigationScreen({Key? key}) : super(key: key);
//   static const routeName = '/brand_navigation';

//   @override
//   _BrandNavigationScreenState createState() => _BrandNavigationScreenState();
// }

// class _BrandNavigationScreenState extends State<BrandNavigationScreen> {
//   final List _brands_images = [
//     "assets/images/brands/Acer.png",
//     "assets/images/brands/Apple.png",
//     "assets/images/brands/Dell.png",
//     "assets/images/brands/HM.png",
//     "assets/images/brands/HP.jpg",
//     "assets/images/brands/Huawei.png",
//     "assets/images/brands/nike.png",
//     "assets/images/brands/Oppo.png",
//     "assets/images/brands/samsung.jpg",
//   ];
//   final List<String> _brands_name = [
//     "All",
//     "Acer",
//     "Apple",
//     "Dell",
//     "H&M",
//     "HP",
//     "Huawei",
//     "Nike",
//     "Oppo",
//     "Samsung",
//   ];
//   int _selectedIndex = 0;
//   String routeArgs = "";
//   String brand = "";
//   int selected = 0;
//   bool selectedButton = false;
//   @override
//   void didChangeDependencies() {
//     routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
//     _selectedIndex = int.parse(
//       routeArgs.substring(1, 2),
//     );
//     print(routeArgs.toString());
//     if (_selectedIndex == 0) {
//       setState(() {
//         brand = 'Acer';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 1) {
//       setState(() {
//         brand = 'Apple';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 2) {
//       setState(() {
//         brand = 'Dell';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 3) {
//       setState(() {
//         brand = 'H&M';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 4) {
//       setState(() {
//         brand = 'HP';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 5) {
//       setState(() {
//         brand = 'Huawei';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 6) {
//       setState(() {
//         brand = 'Nike';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 7) {
//       setState(() {
//         brand = 'Oppo';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     if (_selectedIndex == 8) {
//       setState(() {
//         brand = 'Samsung';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }

//     if (_selectedIndex == 9) {
//       setState(() {
//         brand = 'All';
//         // _selectedIndex++;
//         selectedButton = true;
//       });
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: BrandButtonFilter(
//                 selectedIndex: _selectedIndex,
//                 brandName: _brands_name,
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.85,
//               // margin: EdgeInsets.only(
//               //   bottom: 20,
//               // ),
//               child: ContentSpace(context, brand),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ContentSpace extends StatelessWidget {
//   // final int _selectedIndex;

//   final String brand;
//   // ignore: use_key_in_widget_constructors
//   const ContentSpace(BuildContext context, this.brand);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 7, 0, 0),
//         child: MediaQuery.removePadding(
//           removeTop: true,
//           context: context,
//           child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (BuildContext context, int index) =>
//                 BrandsNavigationRail(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BrandButtonFilter extends StatefulWidget {
//   // const BrandButtonFilter({ Key? key }) : super(key: key);
//   bool _selected = false;
//   final int selectedIndex;
//   bool selected = false;
//   // int index = 0;
//   final List<String> brandName;

//   BrandButtonFilter({
//     Key? key,
//     required this.selectedIndex,
//     required this.brandName,
//   }) : super(key: key);

//   @override
//   _BrandButtonFilterState createState() => _BrandButtonFilterState();
// }

// class _BrandButtonFilterState extends State<BrandButtonFilter> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: widget.brandName.length,
//       itemBuilder: (BuildContext context, int index) {
//         bool localSelect = false;
//         return InkWell(
//           onTap: () {
//             setState(() {
//               localSelect = !localSelect;
//               print("selected index passed: ${widget.selectedIndex}");
//               print(index);
//               print("Local select: $localSelect");
//             });
//           },
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minWidth: 75,
//               maxHeight: MediaQuery.of(context).size.height * 0.025,
//             ),
//             child: Container(
//               padding: EdgeInsets.fromLTRB(25, 2.5, 25, 0),
//               margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
//               child: Text(
//                 widget.brandName[index],
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: localSelect
//                       ? Colors.amber
//                       : Theme.of(context).textSelectionColor,
//                   width: 2,
//                 ),
//                 color:
//                     localSelect ? Colors.amber : Theme.of(context).buttonColor,
//                 borderRadius: BorderRadius.circular(
//                     MediaQuery.of(context).size.height * 0.025),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// // =============================================================




// import 'package:flutter/material.dart';

// import 'brands_rail_widget.dart';

// class BrandNavigationScreen extends StatefulWidget {
//   const BrandNavigationScreen({Key? key}) : super(key: key);
//   static const routeName = '/brand_navigation';

//   @override
//   _BrandNavigationScreenState createState() => _BrandNavigationScreenState();
// }

// class _BrandNavigationScreenState extends State<BrandNavigationScreen> {
//   final List _brands_images = [
//     "assets/images/brands/Acer.png",
//     "assets/images/brands/Apple.png",
//     "assets/images/brands/Dell.png",
//     "assets/images/brands/HM.png",
//     "assets/images/brands/HP.jpg",
//     "assets/images/brands/Huawei.png",
//     "assets/images/brands/nike.png",
//     "assets/images/brands/Oppo.png",
//     "assets/images/brands/samsung.jpg",
//   ];
//   final List _brands_name = [
//     "All",
//     "Acer",
//     "Apple",
//     "Dell",
//     "H&M",
//     "HP",
//     "Huawei",
//     "Nike",
//     "Oppo",
//     "Samsung",
//   ];
//   int _selectedIndex = 0;
//   String routeArgs = "";
//   String brand = "";
//   @override
//   void didChangeDependencies() {
//     routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
//     _selectedIndex = int.parse(
//       routeArgs.substring(1, 2),
//     );
//     print(routeArgs.toString());
//     if (_selectedIndex == 0) {
//       setState(() {
//         brand = 'Acer';
//       });
//     }
//     if (_selectedIndex == 1) {
//       setState(() {
//         brand = 'Apple';
//       });
//     }
//     if (_selectedIndex == 2) {
//       setState(() {
//         brand = 'Dell';
//       });
//     }
//     if (_selectedIndex == 3) {
//       setState(() {
//         brand = 'H&M';
//       });
//     }
//     if (_selectedIndex == 4) {
//       setState(() {
//         brand = 'HP';
//       });
//     }
//     if (_selectedIndex == 5) {
//       setState(() {
//         brand = 'Huawei';
//       });
//     }
//     if (_selectedIndex == 6) {
//       setState(() {
//         brand = 'Nike';
//       });
//     }
//     if (_selectedIndex == 7) {
//       setState(() {
//         brand = 'Oppo';
//       });
//     }
//     if (_selectedIndex == 8) {
//       setState(() {
//         brand = 'Samsung';
//       });
//     }

//     if (_selectedIndex == 9) {
//       setState(() {
//         brand = 'All';
//       });
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _brands_images.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return BrandButtonFilter(
//                     selectedIndex: _selectedIndex,
//                     selected: false,
//                     index: index,
//                     brandName: _brands_name[index],
//                   );
//                 },
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.85,
//               // margin: EdgeInsets.only(
//               //   bottom: 20,
//               // ),
//               child: ContentSpace(context, brand),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ContentSpace extends StatelessWidget {
//   // final int _selectedIndex;

//   final String brand;
//   // ignore: use_key_in_widget_constructors
//   const ContentSpace(BuildContext context, this.brand);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 7, 0, 0),
//         child: MediaQuery.removePadding(
//           removeTop: true,
//           context: context,
//           child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (BuildContext context, int index) =>
//                 BrandsNavigationRail(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BrandButtonFilter extends StatefulWidget {
//   // const BrandButtonFilter({Key? key}) : super(key: key);
//   bool _selected = false;
//   final int selectedIndex;
//   final bool selected;
//   final int index;
//   final String brandName;

//   BrandButtonFilter({
//     Key? key,
//     required this.selectedIndex,
//     required this.selected,
//     required this.index,
//     required this.brandName,
//   }) : super(key: key);

//   @override
//   _BrandButtonFilterState createState() => _BrandButtonFilterState();
// }

// class _BrandButtonFilterState extends State<BrandButtonFilter> {
//   @override
//   Widget build(BuildContext context) {
//     int selected = widget.selectedIndex + 1;
//     // widget.selected = widget.selected;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           // widget.selectedIndex = widget.index;
//           widget._selected = !widget._selected;
//           print(widget.index);
//           print(widget._selected);
//           // setState(() {
//           //   brand = _brands_name[_selectedIndex];
//           // });
//         });
//       },
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minWidth: 75,
//           maxHeight: MediaQuery.of(context).size.height * 0.025,
//         ),
//         child: Container(
//           padding: EdgeInsets.fromLTRB(25, 2.5, 25, 0),
//           margin: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
//           child: Text(
//             widget.brandName,
//             // _brands_name[index],
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: widget._selected || (selected == widget.index)
//                   ? Colors.amber
//                   : Theme.of(context).textSelectionColor,
//               width: 2,
//             ),
//             color: widget._selected || (selected == widget.index)
//                 ? Colors.amber
//                 : Theme.of(context).buttonColor,
//             borderRadius: BorderRadius.circular(
//                 MediaQuery.of(context).size.height * 0.025),
//           ),
//         ),
//       ),
//     );
//   }
// }
