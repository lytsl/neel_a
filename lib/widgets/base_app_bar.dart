import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/utility/functions.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isDarkMode = Fun.isDarkMode(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: AppBar(
        backgroundColor: _isDarkMode?primaryColorDark:primaryColor,
        brightness: ThemeProvider.of(context)!.brightness,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          title,
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: navigateToShopping,
            padding: EdgeInsets.only(right: 8),
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: iconColor,
              size: iconSize,
            ),
          ),
          IconButton(
            onPressed: navigateToProfile,
            padding: EdgeInsets.only(right: 16),
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.person_outline,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56);

  void navigateToShopping() {}

  void navigateToProfile() {}
}
