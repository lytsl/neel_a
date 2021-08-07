import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/pages/cart_page.dart';
import 'package:neel_a/pages/filter_page.dart';
import 'package:neel_a/pages/wish_list_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/product_grid_item.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  static const ID = 'ProductListPage';

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late double windowWidth, _textHeight12, _textHeight14;
  late bool _isDarkMode;
  late Color _greyColor0,_greyColor1, _textColor, _primaryColor;

  final isInCartList =
      List.generate(16, (index) => (index.isEven ? true : false));
  final isFavouriteList =
      List.generate(16, (index) => ((index % 3 == 1) ? true : false));

  late String selectedSort;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    _isDarkMode = Fun.isDarkMode(context);
    _greyColor0 = _isDarkMode ? (greyColorDark) : greyColor0;
    _greyColor1 = _isDarkMode ? (greyColorDark) : greyColor1;
    _textColor = _isDarkMode ? (Colors.white) : Colors.black;
    _primaryColor = _isDarkMode ? (primaryColorDark) : primaryColor;
    _textHeight12 = Fun.textHeight(12, context);
    _textHeight14 = Fun.textHeight(14, context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? bgColorDark : whiteColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            buildAppBar(innerBoxIsScrolled),
          ];
        },
        body: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: ((windowWidth - 8 * 4) / 2) /
                ((windowWidth - 8 * 4 + 4) / 2 +
                    _textHeight12 * 3 +
                    _textHeight14 * 2 +
                    4 * 2 +
                    8 * 5),
          ),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ProductGridItem(
              windowWidth: windowWidth,
              isDarkMode: _isDarkMode,
              textHeight14: _textHeight14,
              textHeight12: _textHeight12,
              onCartClicked: () => addItemToCart(index),
              isInCart: isInCartList[index],
              isFavourite: isFavouriteList[index],
              onFavorite: () => addToFavourite(index),
            );
          },
        ),
      ),
    );
  }

  SliverAppBar buildAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      toolbarHeight: 56,
      leading: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        onPressed: onBackPressed,
        icon: Icon(
          Icons.arrow_back,
          //color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        'Category',
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 8),
          constraints: BoxConstraints(),
          onPressed: navigateToSearch,
          icon: Icon(
            Icons.search,
            color: iconColor,
            size: iconSize,
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(right: 8),
          constraints: BoxConstraints(),
          onPressed: navigateToFavourite,
          icon: Icon(
            Icons.favorite_outline,
            color: iconColor,
            size: iconSize,
          ),
        ),
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
      pinned: true,
      floating: true,
      forceElevated: innerBoxIsScrolled,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(max<double>(_textHeight14, 16) + 16 + 8),
        child: Container(
          color: _isDarkMode ? bgColorDark : bgColor,
          height: max<double>(_textHeight14, 16) + 12*2,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: showSortBottomSheet,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                    backgroundColor: MaterialStateProperty.all<Color>(_isDarkMode ? bgColorDark : bgColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all(Size.zero),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: _textColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Sort',
                        style: TextStyle(fontSize: 14,color: _textColor,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: 2,
                color: _isDarkMode ? greyColorDark : greyColor,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: navigateToFilter,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                    backgroundColor: MaterialStateProperty.all<Color>(_isDarkMode ? bgColorDark : bgColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all(Size.zero),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        size: 16,
                        color: _textColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Filter',
                        style: TextStyle(fontSize: 14,color: _textColor,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onBackPressed() {
    Navigator.pop(context);
  }

  void navigateToCart() {
    Navigator.pushNamed(context, CartPage.ID);
  }

  void navigateToSearch() {}

  void navigateToFavourite() {
    Navigator.pushNamed(context, WishListPage.ID);
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

  void addToFavourite(int index) {
    if (isFavouriteList[index]) {
      Fun.toast('Item deleted from wishlist');
      setState(() {
        isFavouriteList[index] = false;
      });
      return;
    }
    Fun.toast('Item added to wishlist');
    setState(() {
      isFavouriteList[index] = true;
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

  void showSortBottomSheet() {
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
              height: 8,
            ),
            SortByOptions(isDarkMode: _isDarkMode),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void navigateToFilter() {
    Navigator.pushNamed(context, FilterPage.ID);
  }
}

class SortByOptions extends StatefulWidget {
  const SortByOptions({Key? key,required this.isDarkMode,}) : super(key: key);

  final bool isDarkMode;

  @override
  _SortByOptionsState createState() => _SortByOptionsState();
}

class _SortByOptionsState extends State<SortByOptions> {

  final sortByList = [
    'Popularity',
    'Name',
    'Price Low to High',
    'Price High to Low',
    'Discount',
    'New Arrivals'
  ];

  late String selectedSort;

  @override
  void initState() {
    selectedSort = sortByList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _textColor = widget.isDarkMode ? (Colors.white) : Colors.black;
    final _primaryColor = widget.isDarkMode ? (primaryColorDark) : primaryColor;
    return Column(
      children: sortByList
          .map(
            (sortMethod) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 24,
                child: Radio<String>(
                  value: sortMethod,
                  groupValue: selectedSort,
                  activeColor: _primaryColor,
                  onChanged: (String? value) {
                    //print(value);
                    setState(() {
                      selectedSort = value!;
                    });
                  },
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: (){
                  //print(sortMethod);
                  if(selectedSort!=sortMethod){
                    setState(() {
                      selectedSort = sortMethod;
                    });
                  }
                },
                child: Text(
                  sortMethod,
                  style: TextStyle(
                    fontSize: 12,
                    color: (sortMethod == selectedSort)
                        ? _primaryColor
                        : _textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}

