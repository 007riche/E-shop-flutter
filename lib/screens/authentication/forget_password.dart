import 'package:eshop/services/global_alert_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-password-screen';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FocusNode _formNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String _emailAddress = "";

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
            .sendPasswordResetEmail(
              email: _emailAddress.toLowerCase().trim(),
            )
            .then((value) => Fluttertoast.showToast(
                msg: "A reset email has been sent to you.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0))
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 200,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Reset your password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            Icons.email_outlined,
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        onSaved: (value) {
                          _emailAddress = value!;
                        },
                      ),
                    ),
                    _isSending
                        ? Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.20,
                              vertical: 15,
                            ),
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
                              onPressed: _submitForm,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Reset your password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.vpn_key,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
