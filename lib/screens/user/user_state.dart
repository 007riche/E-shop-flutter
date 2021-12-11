import 'package:eshop/screens/landing_page.dart';
import 'package:eshop/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  // const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print("Logged in");
              Navigator.canPop(context) ? Navigator.of(context).pop() : null;
              return MainScreens();
            } else {
              print("Not yet logged in");
              return LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text("Error occured"),
            );
          } else {
            return Text("Uncaugth exception");
          }
        });
  }
}
