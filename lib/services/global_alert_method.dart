import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalAlertMethod {
  Future<void> myShowDialog(
      BuildContext context, String name, String subTitle, Function fct) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 6.0,
                ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/OOjs_UI_icon_alert_destructive_black-darkred.svg/1138px-OOjs_UI_icon_alert_destructive_black-darkred.svg.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                ),
              ),
            ],
          ),
          content: Text(subTitle),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                fct();
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<void> authErrorHandlingDialog({
    required BuildContext context,
    required String subTitle,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 6.0,
                ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/OOjs_UI_icon_alert_destructive_black-darkred.svg/1138px-OOjs_UI_icon_alert_destructive_black-darkred.svg.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "We encountered an error",
                ),
              ),
            ],
          ),
          content: Text(subTitle),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
