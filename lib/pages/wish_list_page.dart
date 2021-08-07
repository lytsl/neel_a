import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/utility/functions.dart';

import 'cart_page.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key,this.fromCartPage = false}) : super(key: key);

  static const ID = 'WishListPage';

  final bool fromCartPage;

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  late bool _isDarkMode;
  late Color _containerColor,
      _greyColor,
      _greyColor1,
      _greyColor0,
      _accentColor,
      _primaryColor,
      _primaryColor1,
      _bgColor;

  late double _windowWidth, _textHeight12, _textHeight14;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final isInCartList =
      List.generate(3, (index) => (index.isEven ? true : false));
  final wishList =
      List.generate(3, (index) => ((index % 3 == 1) ? true : false));

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? bgColorDark : bgColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: wishList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
                  color: _containerColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/product1.jpg',
                        height: 90,
                        width: 90,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: _textHeight12 * 2,
                                    child: Text(
                                      'SBL Arnica Montana 200 CH(30ml)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () => deleteItem(index),
                                  icon: Icon(
                                    Icons.delete_outlined,
                                    color: _greyColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'It is used to improve your blood circulation, boost your immunity',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _greyColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 24),
                              ],
                            ),
                            SizedBox(height: 8),
                            RatingBarIndicator(
                              rating: 4.5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: _accentColor,
                              ),
                              unratedColor: _greyColor,
                              itemCount: 5,
                              itemSize: 12.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '81',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '95',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _greyColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '15% Off',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                //shopping cart icon
                                ElevatedButton(
                                  onPressed: () => addItemToCart(index),
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 16,
                                    color: isInCartList[index]
                                        ? Colors.white
                                        : _greyColor,
                                  ),
                                  style: elevatedButtonRounded.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        isInCartList[index]
                                            ? _primaryColor
                                            : _greyColor0),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(6)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                color: _greyColor0,
                thickness: 1,
                height: 0,
              ),
            ),
          ),
          GestureDetector(
            onTap: _clearWishList,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: _greyColor1,
              ),
              child: Center(
                child: Text(
                  'CLEAR ALL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _accentColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
    _windowWidth = MediaQuery.of(context).size.width;
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
        'My Wishlist (${wishList.length})',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 16),
          constraints: BoxConstraints(),
          onPressed: navigateToCart,
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ],
    );
  }

  void navigateToCart() {
    if(widget.fromCartPage){
      Navigator.pop(context);
      return;
    }
    Navigator.pushNamed(context, CartPage.ID,arguments: true);
  }

  void addItemToCart(int index) {
    if (isInCartList[index]) {
      showCartSnackBar('Item already in cart');
      return;
    }
    showCartSnackBar('Item added to cart');
    setState(() {
      isInCartList[index] = true;
    });
  }

  void showCartSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyle(fontSize: 12),
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          //textColor: Colors.white,
          onPressed: navigateToCart,
        ),
      ),
    );
  }

  void deleteItem(int index) {
    setState(() {
      wishList.removeAt(index);
    });
    Fun.toast('Item removed from wishlist');
  }

  void _clearWishList() {
    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        height: _textHeight14 + _textHeight12*3 +16*4+32,
        width: _windowWidth-32*2,
        padding: EdgeInsets.all(16),
        color: _containerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clear Wishlist',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Are you sure you want to empty your wishlist?',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(fontSize: 12, color: _primaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                              width: 1,
                              color: _primaryColor,
                            ))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(_containerColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all(Size.zero),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  style: elevatedButtonCorner.copyWith(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(_primaryColor),
                  ),
                  onPressed: () {
                    setState(() {
                      wishList.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
    );
  }
}
