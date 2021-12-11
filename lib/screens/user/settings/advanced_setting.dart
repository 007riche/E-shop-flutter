import 'package:flutter/material.dart';

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({Key? key}) : super(key: key);
  static const routeName = "/advanced-settings-screen";
  @override
  _AdvancedSettingsState createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Advanced settings",
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 7,
        ),
      ),
    );
  }
}
