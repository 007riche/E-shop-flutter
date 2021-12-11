// ignore_for_file: prefer_const_constructors

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:eshop/consts/colors.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/screens/user/settings/advanced_setting.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:eshop/screens/orders/user_orders.dart';
import 'package:eshop/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  // const
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ScrollController _scrollController = ScrollController();
  var top = 0.0;
  // bool _value = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
    super.initState();
  }

  String _uid = "";
  String _name = "";
  String _email = "";
  String _joinedAt = "";
  String _phoneNumber = "";
  String _userProfileImageUrl = "";

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    if (!user.isAnonymous) {
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(_uid).get();
      setState(() {
        _name = userDoc.get("name");
        _email = userDoc.get("email");
        _joinedAt = userDoc.get("joinedDate");
        _phoneNumber = userDoc.get("phoneNumber");
        _userProfileImageUrl = userDoc.get("imageUrl");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 4,
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorsConsts.starterColor,
                              ColorsConsts.endColor,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: top <= 110.0 ? 1.0 : 0,
                              duration: Duration(milliseconds: 300),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(
                                            _userProfileImageUrl != ""
                                                ? _userProfileImageUrl
                                                : 'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'
                                            //  ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    _name == ""
                                        ? "Guest"
                                        : "Weclome back ${_name.toString().trim().split(" ").elementAt(0)}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        background: Image(
                          width: MediaQuery.of(context).size.width,
                          image: NetworkImage(
                            _userProfileImageUrl != ""
                                ? _userProfileImageUrl
                                : 'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                          ),
                          // ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: userTitle(context, "Your bag"),
                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: userTitle(context, "User informations"),
                      // ),
                      // Divider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                      // Row(children: [

                      // ],),
                      ListTile(
                        onTap: null,
                        title: Text(
                          "Your Account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(
                          CommunityMaterialIcons.account,
                          size: 45,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Feather.edit,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(UserOrdersScreen.routeName),
                            title: Text("Your Orders"),
                            leading: Icon(AppIcons.selectedShoppingBag),
                            trailing: Icon(AppIcons.nextPage),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            },
                            title: Text("Your Cart"),
                            leading: Icon(AppIcons.cartSelect),
                            trailing: Icon(AppIcons.nextPage),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(WishlistScreen.routeName),
                            title: Text("Your Wishlist"),
                            leading: Icon(AppIcons.wishlistSelect),
                            trailing: Icon(AppIcons.nextPage),
                          ),
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(WishlistScreen.routeName),
                            title: Text("Payments methods"),
                            leading: Icon(Icons.payment),
                            trailing: Icon(AppIcons.nextPage),
                          ),
                        ),
                      ),
                      userListTile(
                        context,
                        0,
                        "Email",
                        _email.length != 0 ? _email : "example@gmail.com",
                      ),
                      userListTile(
                        context,
                        1,
                        "Phone number",
                        // _phoneNumber.length != 0 ||
                        _phoneNumber.isEmpty ? _phoneNumber : "+91 91919-19191",
                      ),
                      userListTile(
                        context,
                        2,
                        "Shipping location",
                        "Mumbai tower",
                      ),
                      userListTile(
                        context,
                        3,
                        "Joined date",
                        _joinedAt.length != 0 ? _joinedAt : "date",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle(context, "Settings"),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      ListTileSwitch(
                        value: themeChange.darkTheme,
                        leading: Icon(themeChange.darkTheme
                            ? BootstrapIcons.moon_stars_fill
                            : BootstrapIcons.sun_fill),
                        onChanged: (value) {
                          setState(() {
                            themeChange.darkTheme = value;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        switchType: SwitchType.material,
                        switchActiveColor: Colors.red,
                        title: Text('Dark theme'),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AdvancedSettings.routeName),
                            title: Text("Advanced settings"),
                            leading: Icon(
                              Icons.settings,
                            ),
                            trailing: Icon(AppIcons.nextPage),
                          ),
                        ),
                      ),
                      // userListTile(context, 4, "Advanced settings", ""),
                      // userListTile(context, 5, "Logout", ""),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).bottomAppBarColor,
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Logout",
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                        "Do you really wnat to logout of the app?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          // Navigator.pop(context);
                                          await _auth.signOut().then((value) {
                                            Navigator.pop(context);
                                          }).then((value) =>
                                              Navigator.canPop(context)
                                                  ? Navigator.pop(context)
                                                  : null);
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            title: Text("Logout"),
                            leading: Icon(Icons.exit_to_app_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildFab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    const double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    const double scaleStart = 160.0;
    //pixels from top where scaling should end
    const double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.location_pin,
    Icons.watch_later,
    Icons.settings,
    Icons.logout_outlined,
  ];

  Widget userListTile(
      BuildContext context, int index, String title, String subtitle) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).bottomAppBarColor,
        child: ListTile(
          onTap: null,
          title: Text(title),
          leading: Icon(_userTileIcons[index]),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  // void setState(Null Function() param0) {}
}

Widget userTitle(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
