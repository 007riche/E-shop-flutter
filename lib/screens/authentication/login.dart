import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/screens/authentication/forget_password.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _formNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailAddress = "";
  String _password = "";
  bool _showPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalAlertMethod _globalAlertMethod = GlobalAlertMethod();
  bool _isSending = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailAddress.toLowerCase().trim(),
                password: _password.trim())
            .then(
              (value) => Navigator.of(context).canPop()
                  ? Navigator.of(context).pop()
                  : null,
            );
      } catch (error) {
        _globalAlertMethod.authErrorHandlingDialog(
            context: context, subTitle: error.toString());
        print(error);
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
    // print("Password: " + _password);
    // print("confirm Password: " + _confirmPassword);
    // print("EMail: " + _emailAddress);
    // print("full name" + _fullName);
    // print("phone: $_phoneNumber");
  }
  // void _submitForm() {
  //   final isValid = _formKey.currentState!.validate();
  //   FocusScope.of(context).unfocus();
  //   if (isValid) {
  //     _formKey.currentState!.save();
  //   }
  // }

  Future<void> _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          var date = DateTime.now().toString();
          var dateParse = DateTime.parse(date);
          var formattedDate =
              "${dateParse.day}-${dateParse.month}-${dateParse.year} ${dateParse.hour}:${dateParse.minute}";
          final authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken, //'', //will cause error
            ),
          );
          await FirebaseFirestore.instance
              .collection("users")
              .doc(authResult.user!.uid)
              .set({
            "id": authResult.user!.uid,
            "name": authResult.user!.displayName,
            "email": authResult.user!.email,
            "phoneNumber": authResult.user!.phoneNumber.toString(),
            "imageUrl": authResult.user!.photoURL,
            "joinedDate": formattedDate,
            "accountCreationdate": Timestamp.now(),
          });
        } catch (error) {
          _globalAlertMethod.authErrorHandlingDialog(
              context: context,
              subTitle: error.toString().replaceAll(RegExp(r'^\[\]$'), ""));
        } finally {
          Navigator.canPop(context) ? Navigator.of(context).pop() : null;
        }
      }
    }
  }

  @override
  void dispose() {
    _formNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          elevation: 7,
          // leadingWidth: 20,
          title: Text("E-shop"),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.red.shade200, Colors.grey.shade300],
                    [Colors.blueGrey.shade300, Colors.blueGrey.shade400],
                    [Colors.blue.shade200, Colors.blue.shade300],
                    [Colors.indigo, Color(0x55FFEB3B)]
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.80, 0.83, 0.85, 0.90],
                  blur: MaskFilter.blur(BlurStyle.inner, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.iconpacks.net/icons/2/free-store-icon-2017-thumb.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains("@") ||
                                  !value.contains(".")) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_formNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                              filled: true,
                              prefix: Icon(
                                Icons.email,
                              ),
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextFormField(
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return "Please enter a valid password";
                              }
                              return null;
                            },
                            focusNode: _formNode,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: _submitForm,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefix: Icon(
                                Icons.lock,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _showPassword,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ForgotPassword.routeName);
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _isSending
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          // side: BorderSide(color: ColorsConsts.background),
                                        ),
                                      ),
                                    ),
                                    onPressed: _submitForm,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.20,
                        vertical: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            // side: BorderSide(color: ColorsConsts.background),
                          ),
                        ),
                      ),
                      onPressed: _googleSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login with Google+',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
