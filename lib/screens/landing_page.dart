// import 'package:eshop/consts/colors.dart';
import 'package:eshop/screens/authentication/login.dart';
import 'package:eshop/screens/authentication/sign_up.dart';
import 'package:eshop/screens/bottom_bar.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> _backgrpundAnimationImages = [
    "https://cdn-elle.ladmedia.fr/var/plain_site/storage/images/love-sexe/psycho/addiction-au-shopping-il-fallait-a-tout-prix-assouvir-cette-envie-3921883/94726721-1-fre-FR/Addiction-au-shopping-Il-fallait-a-tout-prix-assouvir-cette-envie.jpg",
    "https://www.gannett-cdn.com/presto/2021/10/16/USAT/a33bf9ac-d8e6-4a7e-8ade-a2e52cf4c2c8-Holidays.png",
    'https://www.woolvertoninn.com/wp-content/uploads/2018/11/holiday-shopping-banner.jpg',
    "https://blog.mozilla.org/wp-content/blogs.dir/278/files/2018/11/Black-Friday-Headline.png",
  ];

  @override
  void initState() {
    _backgrpundAnimationImages.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 30));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalAlertMethod _globalAlertMethod = GlobalAlertMethod();
  bool _isSending = false;

  void _anonymousLogin() async {
    // final isValid = _formKey.currentState!.validate();
    // FocusScope.of(context).unfocus();
    // if (isValid) {
    setState(() {
      _isSending = true;
    });
    // _formKey.currentState!.save();
    try {
      await _auth.signInAnonymously();
    } catch (error) {
      _globalAlertMethod.authErrorHandlingDialog(
          context: context, subTitle: error.toString());
      print(error);
    } finally {
      setState(() {
        _isSending = false;
      });
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: _backgrpundAnimationImages[0],
              placeholder: (context, url) => Image.asset(
                "assets/images/landingPagePlaceholder.jpg",
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: FractionalOffset(_animation.value, 0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to E-shop",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Text(
                      "Your shopping, our duty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: BorderSide(color: ColorsConsts.background),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.login_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: BorderSide(color: ColorsConsts.),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Feather.user_plus,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ),
                    Text("Or"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                // OutlinedButton(
                //   style: ButtonStyle(
                //     shape: MaterialStateProperty.all<StadiumBorder>(
                //       StadiumBorder(
                //         side: BorderSide(
                //           width: 0,
                //           color: Color(0xAAFF0000),
                //           style: BorderStyle.none,
                //         ),
                //       ),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: ,
                // ),
                // OutlineButton(
                //   onPressed: () {},
                //   child: Text(
                //     "Continue as a guest",
                //     style: TextStyle(
                //       color: Colors.indigo.shade900,
                //     ),
                //   ),
                //   shape: StadiumBorder(),
                //   borderSide: BorderSide(
                //     width: 2,
                //     color: Colors.indigo.shade900,
                //   ),
                // ),
                // SizedBox(
                //   height: 40,
                // ),
                _isSending
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: BorderSide(color: ColorsConsts.),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _anonymousLogin();
                          // Navigator.pushNamed(context, BottomBarScreen.routeName);
                        },
                        child: Text(
                          'Continue as a guest',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
