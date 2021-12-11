import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/consts/icons.dart';
import 'package:eshop/provider/dark_theme_provider.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _formEmailNode = FocusNode();
  final FocusNode _formPasswordNode = FocusNode();
  final FocusNode _formConfirmPasswordNode = FocusNode();
  final FocusNode _formPhoneNumberNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _fullName = "";
  String _emailAddress = "";

  String _password = "";
  String _confirmPassword = "";
  int _phoneNumber = 0;
  bool _showPassword = true;
  bool _showConfirmPassword = true;
  var _pickedImage = null;
  String _userImageUrl = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalAlertMethod _globalAlertMethod = GlobalAlertMethod();
  bool _isSending = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year} ${dateParse.hour}:${dateParse.minute}";
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          _globalAlertMethod.authErrorHandlingDialog(
              context: context, subTitle: "Please choose an image");
        } else {
          setState(() {
            _isSending = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("usersProfileImages")
              .child(_fullName.toString().replaceAll(" ", "_") + ".png");
          await ref.putFile(_pickedImage);
          _userImageUrl = await ref.getDownloadURL();

          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User? currentUser = _auth.currentUser;
          final _uid = currentUser!.uid;
          await FirebaseFirestore.instance.collection("users").doc(_uid).set({
            "id": _uid,
            "name": _fullName,
            "email": _emailAddress,
            "phoneNumber": _phoneNumber.toString(),
            "imageUrl": _userImageUrl,
            "joinedDate": formattedDate,
            "accountCreationdate": Timestamp.now(),
          });
          Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
        }
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
  }

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

  void _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _formPasswordNode.dispose();
    _formConfirmPasswordNode.dispose();
    _formPhoneNumberNode.dispose();
    _formEmailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    String emailAddress = "";
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
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: themeChange.darkTheme
                                ? Theme.of(context).textSelectionColor
                                : Theme.of(context).scaffoldBackgroundColor,
                            backgroundImage: _pickedImage == null
                                ? null
                                : FileImage(_pickedImage),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        left: 90,
                        child: RawMaterialButton(
                          elevation: 10,
                          fillColor: Theme.of(context).backgroundColor,
                          padding: EdgeInsets.all(15.0),
                          child: Icon(Icons.add_a_photo),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    title: Text(
                                      "Your Picture",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: _pickImageFromCamera,
                                            splashColor:
                                                Theme.of(context).accentColor,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Theme.of(context)
                                                        .textSelectionColor,
                                                  ),
                                                ),
                                                Text(
                                                  "From Camera",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .textSelectionColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _pickImageFromGallery,
                                            splashColor:
                                                Theme.of(context).accentColor,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Theme.of(context)
                                                        .textSelectionColor,
                                                  ),
                                                ),
                                                Text(
                                                  "From gallery",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .textSelectionColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _removeImage,
                                            splashColor:
                                                Theme.of(context).accentColor,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red.shade800,
                                                  ),
                                                ),
                                                Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          Colors.red.shade800,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: TextFormField(
                            key: ValueKey('name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your full name here! ";
                              }
                              if (value.split(" ").length < 2) {
                                return "Please enter your FULL NAME";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_formEmailNode),
                            keyboardType: TextInputType.text,
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
                                AppIcons.user,
                              ),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onSaved: (value) {
                              setState(() {
                                _fullName = value!;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
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
                            focusNode: _formEmailNode,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_formPasswordNode),
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
                              setState(() {
                                _emailAddress = value!;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: TextFormField(
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return "Please enter a valid password address";
                              }
                              if (_confirmPassword != _password) {
                                return "Passwords are not the same";
                              }
                              return null;
                            },
                            focusNode: _formPasswordNode,
                            keyboardType: TextInputType.text,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_formConfirmPasswordNode),
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
                              setState(() {
                                _password = value!;
                              });
                            },
                            obscureText: _showPassword,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: TextFormField(
                            key: ValueKey('confirmPassword'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return "Enter your password again";
                              }
                              if (_password != _confirmPassword) {
                                return "Passwords are not the same";
                              }
                              return null;
                            },
                            focusNode: _formConfirmPasswordNode,
                            keyboardType: TextInputType.text,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_formPhoneNumberNode),
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
                                    _showConfirmPassword =
                                        !_showConfirmPassword;
                                  });
                                },
                                child: Icon(
                                  _showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              labelText: 'Confirm password',
                              labelStyle: TextStyle(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onSaved: (value) {
                              setState(() {
                                _confirmPassword = value!;
                              });
                            },
                            obscureText: _showConfirmPassword,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: TextFormField(
                            key: ValueKey('phoneNumber'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your phone number here";
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            focusNode: _formPhoneNumberNode,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _submitForm,
                            keyboardType: TextInputType.phone,
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
                                Icons.phone,
                              ),
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onSaved: (value) {
                              setState(() {
                                _phoneNumber = int.parse(value!);
                              });
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
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
                                          'Sign Up',
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                                  'Sign Up with Google+',
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
          ],
        ),
      ),
    );
  }
}
