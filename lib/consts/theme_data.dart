// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarktheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarktheme ? const Color(0xFF001F3F) : Colors.grey.shade200,

      primarySwatch: Colors.blueGrey,
      primaryColor:
          isDarktheme ? const Color(0xFF001F3F) : Colors.grey.shade300,
      accentColor: Colors.red,
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
      //     .copyWith(secondary: Colors.red),
      backgroundColor: isDarktheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor:
          isDarktheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      buttonColor:
          isDarktheme ? const Color(0xff3B3B3B) : const Color(0xffF1F5FB),
      hintColor: isDarktheme ? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor:
          isDarktheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarktheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarktheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey.shade300,
      textSelectionColor: isDarktheme ? Colors.white : Colors.black,
      cardColor: isDarktheme ? const Color(0xff151515) : Colors.white10,
      canvasColor: isDarktheme ? Colors.black54 : Colors.white,
      brightness: isDarktheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        foregroundColor: isDarktheme ? Colors.white : Colors.grey.shade800,
        iconTheme: IconThemeData(
          color: isDarktheme ? Colors.white : Colors.grey.shade800,
        ),
        actionsIconTheme: IconThemeData(
          color: isDarktheme ? Colors.white : Colors.grey.shade800,
        ),
      ),
    );
  }
}
