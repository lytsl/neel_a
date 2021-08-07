import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/constants.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/pages/address_list_page.dart';
import 'package:neel_a/pages/wish_list_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_container.dart';
import 'package:neel_a/widgets/my_text_field.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
    this.fromWishList = false,
  }) : super(key: key);

  static const ID = 'CartPage';

  final bool fromWishList;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  final productQuantityList = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      backgroundColor: _isDarkMode ? bgColorDark : bgColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _checkOutIndicator(),
                SizedBox(height: 8),
                _buildSelectedLocation(),
                _addForFreeDelivery(),
                _buildCoupon(),
                _productList(),
                _priceDetails(),
                SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _containerColor,
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: _greyColor1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(fontSize: 10, color: _greyColor),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: placeOrder,
                  style: elevatedButtonCorner,
                  child: Text(
                    'PLACE ORDER',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
        'My Cart (${productQuantityList.length})',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: _textHeight12 + 8 + 2,
          child: ElevatedButton(
            child: Text(
              'WISHLIST',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            onPressed: navigateToWishPage,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ))),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              )),
              backgroundColor: MaterialStateProperty.all<Color>(_primaryColor),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: MaterialStateProperty.all(Size.zero),
            ),
          ),
        ),
      ],
    );
  }

  Container _productList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _greyColor0),
        color: _containerColor,
      ),
      child: ListView.separated(
        itemCount: productQuantityList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints(),
                            onPressed: () => removeItemFromCart(index),
                            icon: Icon(
                              Icons.delete_outlined,
                              color: _greyColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '95',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _greyColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '81',
                                    style: TextStyle(fontSize: 12),
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
                            ],
                          ),
                          //quantity
                          ElevatedButton(
                            onPressed: () => _quantityDialog(index),
                            child: Row(
                              children: [
                                Text(
                                  'Qty : ',
                                  style: TextStyle(
                                      fontSize: 12, color: _greyColor),
                                ),
                                Text(
                                  productQuantityList[index].toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 16,
                                  color: _greyColor,
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(
                                        width: 1,
                                        color: _greyColor1,
                                      ))),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _containerColor),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              elevation: MaterialStateProperty.all(0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Sub Total: ',
                              style: TextStyle(fontSize: 10, color: _greyColor),
                            ),
                            Text(
                              (productQuantityList[index] * 81).toString(),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Item will be delivered within 4-6 business days',
                        style: TextStyle(
                          fontSize: 10,
                          color: _greyColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 0,
          thickness: 1,
          color: _greyColor0,
        ),
      ),
    );
  }

  Widget _addForFreeDelivery() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(4),
            color: _containerColor,
            border: Border(
              left: BorderSide(
                color: _primaryColor,
                width: 4.0,
              ),
              /*top: BorderSide(color: _greyColor1),
              bottom: BorderSide(color: _greyColor1),
              right: BorderSide(color: _greyColor1),*/
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: _greyColor,
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                'Add 200 to your order for FREE Delivery',
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void changeAddress() {
    Navigator.pushNamed(context, AddressListPage.ID);
  }

  void _quantityDialog(int index) async {
    int quantity = productQuantityList[index];

    int? selectedQuantity = await showGeneralDialog<int>(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: inPageDuration,
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: _textHeight12 * 12 + 8 * 2 * 11 + 2 * 11 + 24,
            margin: EdgeInsets.symmetric(
              horizontal: _windowWidth / 5, /*vertical: _windowWidth/4,*/
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _isDarkMode ? bgColorDark : bgColor,
            ),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Select Quantity',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, quantityIndex) {
                        return GestureDetector(
                          onTap: () => returnQuantity(quantityIndex + 1),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: (quantity == quantityIndex + 1)
                                  ? _primaryColor1
                                  : _bgColor,
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: _greyColor1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (quantityIndex + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _greyColor,
                                  ),
                                ),
                                Visibility(
                                    visible: (quantity == quantityIndex + 1),
                                    child: Icon(
                                      Icons.done,
                                      size: 20,
                                      color: _greyColor,
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

    if (selectedQuantity != null) {
      setState(() {
        productQuantityList[index] = selectedQuantity;
      });
    }
  }

  void returnQuantity(int quantity) {
    Navigator.pop(context, quantity);
  }

  MyContainer _buildSelectedLocation() {
    return MyContainer(
      isDarkMode: _isDarkMode,
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: _greyColor,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
              child: Text(
            'Shoving availability at 380001',
            style: TextStyle(fontSize: 12),
          )),
          SizedBox(width: 8),
          ElevatedButton(
            child: Text(
              'CHANGE',
              style: TextStyle(fontSize: 12, color: _accentColor),
            ),
            onPressed: showAddressModalSheet,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        width: 1,
                        color: _accentColor,
                      ))),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(_containerColor),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: MaterialStateProperty.all(Size.zero),
            ),
          ),
        ],
      ),
    );
  }

  Card _checkOutIndicator() {
    return Card(
      margin: EdgeInsets.zero,
      color: _containerColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 2,
                    color: _greyColor1,
                  ),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _greyColor1,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 2,
                    color: _greyColor1,
                  ),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _greyColor1,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Summary',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void placeOrder() {}

  void navigateToWishPage() {
    if (widget.fromWishList) {
      Navigator.pop(context);
      return;
    }
    Navigator.pushNamed(context, WishListPage.ID, arguments: true);
  }

  removeItemFromCart(int index) {
    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        height: _textHeight14 + _textHeight12 * 7 + 16 * 5,
        width: _windowWidth - 32 * 2,
        padding: EdgeInsets.all(16),
        color: _containerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/product1.jpg',
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Remove Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Are you sure you want to remove Becadexamin Soft Gelatin Capsule (30caps) from cart?',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text(
                    (index.isEven) ? 'MOVE TO WISHLIST' : 'CANCEL',
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
                      productQuantityList.removeAt(index);
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

  Widget _priceDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRICE DETAILS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              //color: _greyColor,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _greyColor0),
              color: _containerColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total MRP',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                    Text(
                      '626',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item Discount',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                    Text(
                      '-49',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Charge',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                    Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 12,
                        color: _greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '577',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: _isDarkMode ? primaryColorDark : primaryColor1,
            child: Text(
              'You saved 49 on this order',
              style: TextStyle(
                fontSize: 12,
                color: _greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoupon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COUPONS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: showCouponModalSheet,
              style: ElevatedButton.styleFrom(
                primary: _containerColor,
                onPrimary: _primaryColor,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: _greyColor0)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_activity_outlined,
                    size: 20,
                    color: _textColor,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Apply Coupon',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: _textColor,
                  ),
                  //SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCouponModalSheet() {
    String code = '';

    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort By',
                    style: TextStyle(fontSize: 14),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: _greyColor1,
              height: 0,
            ),
            //SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: MyTextField(
                          onChanged: (v) => code = v,
                          hint: 'Enter coupon code',
                          isDarkMode: _isDarkMode)),
                  SizedBox(width: 16),
                  ElevatedButton(onPressed: () {}, child: Text('APPLY')),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: _windowHeight * (0.4),
              width: double.infinity,
              color: _bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_activity_outlined,
                    size: 40,
                    color: _greyColor,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Coupons not available!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _greyColor,
                    ),
                  ),
                  Text(
                    'Right now we do not have any coupons for you',
                    style: TextStyle(
                      fontSize: 12,
                      color: _greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddressModalSheet() {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Container(
        //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: _bgColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select Address',
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select delivery location to see product availability',
                style: TextStyle(fontSize: 12, color: _greyColor),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: _textHeight12 * 6 + 8 * 6,
              child: ListView.builder(
                itemCount: 3 + 1,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 3)
                    return GestureDetector(
                      onTap: changeAddress,
                      child: Container(
                        height: _textHeight12 * 6 + 8 * 5 + 6,
                        width: _windowWidth * (0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _greyColor0),
                          color: _containerColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 16,
                              color: _primaryColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Add new address',
                              style:
                                  TextStyle(fontSize: 12, color: _primaryColor),
                            )
                          ],
                        ),
                      ),
                    );
                  return Container(
                    height: _textHeight12 * 6 + 8 * 5 + 6,
                    width: _windowWidth * (0.4),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: (index == 0) ? _accentColor : _greyColor0),
                      color: (index == 0)
                          ? _accentColor.withOpacity(0.1)
                          : _containerColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: _bgColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _greyColor,
                                ),
                              ),
                            ),
                            Text(
                              'DEFAULT',
                              style: TextStyle(
                                fontSize: 10,
                                color: _greyColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: _textHeight12 * 4,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12.0,
                                color:
                                    _isDarkMode ? Colors.white : Colors.black,
                              ),
                              children: [
                                TextSpan(text: '101, '),
                                TextSpan(text: 'a road sz sfjas, '),
                                TextSpan(text: 'b place asjb aka aihka, '),
                                TextSpan(text: 'Ahmadabad - '),
                                TextSpan(text: '380001'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: showEnterPinCodeSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Enter Pin Code',
                      style: TextStyle(
                        fontSize: 14,
                        color: _textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: showCurrentLocationSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Use my current location',
                      style: TextStyle(
                        fontSize: 14,
                        color: _textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void showEnterPinCodeSheet() {
    String pinCode = '';

    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Enter Pincode',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: MyTextField(
                          onChanged: (v) => pinCode = v,
                          hint: 'Pin Code',
                          autoFocus: true,
                          isDarkMode: _isDarkMode)),
                  SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6)
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Text('SAVE',style: TextStyle(fontSize: 12),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void showCurrentLocationSheet() {}
}
