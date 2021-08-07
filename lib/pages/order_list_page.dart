import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/pages/consult_doctor_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_container.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  static const ID = 'OrderListPage';

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late bool _isDarkMode;
  late Color _containerColor,
      _greyColor,
      _greyColor1,
      _greyColor0,
      _accentColor,
      _primaryColor,
      _primaryColor1,
      _bgColor,
      _textColor;
  late double _windowWidth, _textHeight12, _textHeight14, _windowHeight;

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: _bgColor,

    );
  }

  void buildInit() {
    _isDarkMode = Fun.isDarkMode(context);
    _containerColor = _isDarkMode ? (lightBlack) : whiteColor;
    _greyColor = _isDarkMode ? (greyColorDark) : greyColor;
    _greyColor0 = _isDarkMode ? (greyColorDark) : greyColor0;
    _greyColor1 = _isDarkMode ? (greyColorDark) : greyColor1;
    _accentColor = _isDarkMode ? (accentColorDark) : accentColor;
    _primaryColor = _isDarkMode ? (primaryColorDark) : primaryColor;
    _primaryColor1 = _isDarkMode ? (lightBlack) : primaryColor1;
    _bgColor = _isDarkMode ? (bgColorDark) : bgColor;
    _textColor = _isDarkMode ? Colors.white : Colors.black;

    _windowWidth = MediaQuery.of(context).size.width;
    _windowHeight = MediaQuery.of(context).size.height;
    _textHeight12 = Fun.textHeight(12, context);
    _textHeight14 = Fun.textHeight(14, context);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      //backgroundColor: primaryColor,
      //brightness: MediaQuery.of(context).platformBrightness,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'Your Appointments',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
    );
  }

}
