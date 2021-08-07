import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({Key? key,required this.isDarkMode,required this.child,}) : super(key: key);

  final bool isDarkMode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final _containerColor = isDarkMode ? (lightBlack) : whiteColor;
    final _greyColor0 = isDarkMode ? (greyColorDark) : greyColor0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _greyColor0),
        color: _containerColor,
      ),
      child: this.child,
    );
  }
}