import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neel_a/constants/colors.dart';

final lightTheme = ThemeData.light().copyWith(

  /*colorScheme: ColorScheme.light(
    primary: primaryColor,
  ),*/

  brightness: Brightness.light,
  backgroundColor: bgColor,
  primaryColor: primaryColor,
  accentColor: accentColor,

  buttonColor: accentColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(accentColor),
    ),
  ),

  textTheme: GoogleFonts.varelaTextTheme(),
);

final darkTheme = ThemeData.dark().copyWith(

  /*colorScheme: ColorScheme.dark(
    primary: primaryColorDark,
  ),*/

  brightness: Brightness.dark,
  backgroundColor: bgColorDark,
  primaryColor: primaryColorDark,
  accentColor: accentColorDark,

  buttonColor: accentColorDark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(accentColorDark),
    ),
  ),

  textTheme: GoogleFonts.varelaTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  ),
);
//varela
//muli
//rubik
//lato
