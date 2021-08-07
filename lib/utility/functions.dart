import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Fun{

  static void toast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static snackBar(String? message,BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message!),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static double textHeight(double fontSize, BuildContext context) =>
      (TextPainter(
          text: TextSpan(text: 'text', style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold)),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
          .size.height;

  static bool isDarkMode(BuildContext context){
    return ThemeProvider.of(context)!.brightness == Brightness.dark;
  }

}