import 'package:flutter/material.dart';

import 'colors.dart';

final elevatedButtonCorner = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
  //backgroundColor: MaterialStateProperty.all<Color>(accentColor),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: MaterialStateProperty.all(Size.zero),
);

final elevatedButtonRounded = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
  //backgroundColor: MaterialStateProperty.all<Color>(accentColor),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: MaterialStateProperty.all(Size.zero),
);


