import 'package:eshop/consts/theme_data.dart';
import 'package:eshop/inner_screens/categories_feeds.dart';
import 'package:eshop/provider/orders_provider.dart';
import 'package:eshop/screens/authentication/forget_password.dart';
import 'package:eshop/screens/orders/user_orders.dart';
import 'package:eshop/screens/uplaod_product_form.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/provider/products_provider.dart';
import 'package:eshop/screens/user/settings/advanced_setting.dart';
import 'package:eshop/screens/authentication/login.dart';
import 'package:eshop/screens/authentication/sign_up.dart';
import 'package:eshop/screens/cart/cart.dart';
import 'package:eshop/screens/feeds.dart';
import 'package:eshop/screens/landing_page.dart';
import 'package:eshop/screens/main_screen.dart';
import 'package:eshop/screens/user/user_state.dart';
import 'package:eshop/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inner_screens/brand_navigation_screen.dart';
import 'inner_screens/product_details_screen.dart';
import 'provider/wishlist_provider.dart';
import 'screens/bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("We encontered an error"),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) {
                  return themeChangeProvider;
                },
              ),
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishListProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              // stream: null,
              builder: (context, themeData, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'eshop',
                  // themeMode: ThemeMode.system,
                  // darkTheme: ThemeData(primarySwatch: Colors.grey),
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  // ThemeData(
                  //   primarySwatch: Colors.blueGrey,
                  // ),
                  home: UserState(),
                  // MainScreens(), //LandingPage(), //const BottomBarScreen(),
                  routes: {
                    BrandNavigationScreen.routeName: (context) =>
                        BrandNavigationScreen(),
                    FeedsScreen.routeName: (context) => FeedsScreen(),
                    CartScreen.routeName: (context) => CartScreen(),
                    WishlistScreen.routeName: (context) => WishlistScreen(),
                    ProductDetails.routeName: (context) => ProductDetails(
                          description: '',
                          name: '',
                          price: 0,
                          imageUrl: [],
                        ),
                    CategoriesFeedsScreen.routeName: (context) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (context) => LoginScreen(),
                    SignUpScreen.routeName: (context) => SignUpScreen(),
                    BottomBarScreen.routeName: (context) => BottomBarScreen(),
                    AdvancedSettings.routeName: (context) => AdvancedSettings(),
                    UploadProductForm.routeName: (context) =>
                        UploadProductForm(),
                    ForgotPassword.routeName: (context) => ForgotPassword(),
                    UserOrdersScreen.routeName: (context) => UserOrdersScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
