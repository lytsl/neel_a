import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/data/category.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/category_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const ID = 'SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  late double _windowWidth, _textHeight12, _textHeight14;

  String searchText = '';
  bool isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    buildInit();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSearchBody(),
          ],
        ),
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
    _textHeight12 = Fun.textHeight(12, context);
    _textHeight14 = Fun.textHeight(14, context);
  }

  TextField _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (v) {
        setState(() {
          this.searchText = v;
        });
      },
      controller: _searchController,
      autofocus: true,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: _containerColor,
        hintText: 'Search',
        hintStyle: TextStyle(color: _greyColor, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        suffixIcon: Visibility(
          visible: searchText.length > 0,
          child: IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              size: iconSize,
              color: _textColor,
            ),
            onPressed: () {
              _searchController.clear();
              setState(() {
                searchText = '';
              });
            },
          ),
        ),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: iconSize,
            color: _textColor,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
        prefixIconConstraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
        suffixIconConstraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: _greyColor)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: _greyColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: _greyColor)),
      ),
    );
  }

  Widget _buildSearchBody() {
    if (searchText.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            SizedBox(height: 24),
            Icon(
              Icons.search,
              size: 32,
              color: _greyColor,
            ),
            SizedBox(height: 8),
            Text(
              'Make your search better',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              width: double.infinity,
              child: Text(
                'Search by category - Search by brand name - Search by disease - Search by product name - Search by related keywords',
                style: TextStyle(fontSize: 12, color: _greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RECENTLY EXPLORED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Still Interested?',
                      style: TextStyle(fontSize: 10, color: _greyColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100 + 8 * 3 + _textHeight12*4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _containerColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _greyColor0),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    width: 100+16*2,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/product1.jpg',
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Evion Capsule (400mg)(10caps)',
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '81',
                              style: TextStyle(fontSize: 12),
                            ),
                            /*SizedBox(width: 8),
                            Text(
                              '95',
                              style: TextStyle(
                                fontSize: 10,
                                color: _greyColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),*/
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
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: ListView(
        children: buildSearchList(),
      ),
    );
  }

  List<Widget> buildSearchList() {
    final List<Widget> searchList = List.generate(8, (index) {
      if (index < 4)
        return SearchResultItem(
          result: 'A bc Abc abcd ' + index.toString(),
          category: 'Category $index',
          search: 'a',
          isDarkMode: _isDarkMode,
          imageProvider: AssetImage('images/categories$index.png'),
        );
      return SearchResultItem(
        result: 'A bc Abc abcd ' + index.toString(),
        search: 'a',
        isDarkMode: _isDarkMode,
      );
    });

    searchList.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'PRODUCTS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _greyColor0),
              color: _containerColor,
            ),
            child: Column(
              children: List.generate(
                3,
                (index) => Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: _greyColor0,
                      width: 1,
                    )),
                    color: _containerColor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/product1.jpg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: _textHeight12 * 2,
                              child: Text(
                                'SBL Arnica Montana 200 CH(30ml)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 8),
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
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => addItemToCart(index),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 16,
                          color: false ? Colors.white : _greyColor,
                        ),
                        style: elevatedButtonRounded.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              false ? _primaryColor : _greyColor0),
                          padding: MaterialStateProperty.all(EdgeInsets.all(6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _containerColor,
                onPrimary: _accentColor,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('View More',style: TextStyle(fontSize: 12),),
              onPressed: viewMoreProducts,
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    ));

    return searchList;
  }

  void addItemToCart(int index) {}

  void viewMoreProducts() {
  }
}

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    Key? key,
    required this.result,
    required this.search,
    this.imageProvider,
    this.category,
    required this.isDarkMode,
  }) : super(key: key);

  final ImageProvider? imageProvider;
  final String result, search;
  final String? category;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final _primaryColor = isDarkMode ? (primaryColorDark) : primaryColor;
    final _containerColor = isDarkMode ? (lightBlack) : whiteColor;

    final List<InlineSpan> resultInlineSpan = [];
    for (int i = 0; i < result.length;) {
      int j = result.toLowerCase().indexOf(search.toLowerCase(), i);
      print(j);
      if (j == -1) {
        resultInlineSpan.add(
          TextSpan(text: result.substring(i, result.length)),
        );
        break;
      }

      resultInlineSpan.add(
        TextSpan(text: result.substring(i, min<int>(j, result.length))),
      );

      resultInlineSpan.add(
        TextSpan(
          text: result.substring(j, min<int>(j + search.length, result.length)),
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      );
      i = j + search.length;
    }
    return Container(
      padding: EdgeInsets.all(8),
      color: _containerColor,
      height: 40+8*2,
      child: Row(
        children: [
          (imageProvider == null)
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                    Icons.search,
                    size: iconSize,
                  ),
              )
              : Image(
                  image: imageProvider!,
                  height: 40,
                  width: 40,
                ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                      children: resultInlineSpan,
                    ),
                  ),
                ),
                (category == null)
                    ? Container()
                    : Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          'Search in ' + category!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10,
                            color: _primaryColor,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.north_west,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
