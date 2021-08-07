import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_checkbox_tile.dart';
import 'package:neel_a/widgets/my_text_field.dart';
import 'package:neel_a/widgets/tree_view/node_widget.dart';
import 'package:neel_a/widgets/tree_view/tree_controller.dart';
import 'package:neel_a/widgets/tree_view/tree_node.dart';
import 'package:neel_a/widgets/tree_view/tree_view.dart';
import 'package:neel_a/widgets/vertical_tabs.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  static const ID = 'FilterPage';

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
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

  final priceList = ['Below 200', '201-500', '501-1000', 'Above 1000'];
  final brandList = List.generate(20, (index) => 'aaa$index');
  final selectedPriceList = List.generate(4, (index) => false);
  final selectedBrandList = List.generate(20 + 9, (index) => false);

  String searchBrandText = '';
  bool _isSearching = false;

  @override
  void initState() {
    brandList.add('bbbb');
    brandList.add('bccc');
    brandList.add('bccd');
    brandList.add('cbbb');
    brandList.add('cccc');
    brandList.add('cccd');
    brandList.add('dbbb');
    brandList.add('dccc');
    brandList.add('dccd');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildInit();
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: VerticalTabs(
              tabsWidth: 130,
              selectedTabTextStyle: TextStyle(
                fontSize: 12,
                color: _primaryColor,
              ),
              selectedTabBackgroundColor: _containerColor,
              tabTextStyle: TextStyle(
                fontSize: 12,
                color: _textColor,
              ),
              tabBackgroundColor: _bgColor,
              disabledChangePageFromContentView: true,
              //contentScrollAxis: Axis.vertical,
              tabs: <Tab>[
                Tab(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Category',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Price',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Brand',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Treatment',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
              contents: <Widget>[
                _buildCategoryView(),
                _buildPriceView(),
                _buildBrandView(),
                _buildBrandView(),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: _greyColor1,
            height: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '14000 results',
                  style: TextStyle(fontSize: 14),
                ),
                ElevatedButton(
                  style: elevatedButtonCorner.copyWith(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32,vertical: 8,))
                  ),
                  onPressed: applyFilter,
                  child: Text('APPLY'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPriceView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    activeColor: _primaryColor,
                    value: selectedPriceList[index],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceList[index] = value!;
                      });
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPriceList[index] = !selectedPriceList[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                  child: Text(
                    priceList[index],
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              )
            ],
          );
        },
        itemCount: priceList.length,
      ),
    );
  }

  Widget _buildCategoryView() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(0),
        child: Expanded(
          child: TreeView(
            iconSize: 16,
            indent: 16,
            treeController: TreeController(allNodesExpanded: false),
            nodes: [
              TreeNode(
                content: 'Beauty & Personal care  ',
                children: [
                  TreeNode(
                    content: 'Skin Care 1  ',
                    children: [
                      TreeNode(
                        content: 'Face  ',
                        children: [
                          TreeNode(content: 'Face 1 '),
                          TreeNode(content: 'Face 2 '),
                          TreeNode(content: 'Face 3 '),
                          TreeNode(content: 'Face 4 '),
                          TreeNode(content: 'Face 5 '),
                        ],
                      ),
                      TreeNode(content: 'b 2 '),
                      TreeNode(content: 'b 3 '),
                    ],
                  ),
                  TreeNode(content: 'b 2 '),
                  TreeNode(content: 'b 3 '),
                  TreeNode(content: 'b 4 '),
                  TreeNode(content: 'b 5 '),
                ],
              ),
            ],
          ),
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
    _textColor = _isDarkMode ? (Colors.white) : Colors.black;

    _windowWidth = MediaQuery.of(context).size.width;
    _textHeight12 = Fun.textHeight(12, context);
    _textHeight14 = Fun.textHeight(14, context);

    NodeWidget.isDarkMode = _isDarkMode;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      //backgroundColor: primaryColor,
      //brightness: MediaQuery.of(context).platformBrightness,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'Filter',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: clearAllFilter,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.only(right: 16)),
          ),
          child: Text(
            'Clear All',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void clearAllFilter() {}

  Widget _buildBrandView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          SearchTextField(
            onChanged: (v) {
              this.searchBrandText = v;
              if (v.isEmpty && _isSearching) {
                setState(() {
                  _isSearching = false;
                });
              } else if (v.isNotEmpty && !_isSearching) {
                setState(() {
                  _isSearching = true;
                });
              }
            },
            hint: 'Search in Brand',
            isDarkMode: _isDarkMode,
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: _isSearching ? _buildSearchList() : _buildList(),
            ),
          ),
        ],
      ),
    );
  }

  List<MyCheckBox> _buildList() {
    return List.generate(
      brandList.length,
      (index) => MyCheckBox(
        isDarkMode: _isDarkMode,
        value: selectedBrandList[index],
        onChanged: () {
          setState(() {
            selectedBrandList[index] = !selectedBrandList[index];
          });
        },
        label: brandList[index],
      ),
    );
  }

  List<Widget> _buildSearchList() {
    if (searchBrandText.isEmpty) {
      return _buildList();
    } else {
      List<String> _brandList = [];
      List<bool> _selectedBrandList = [];
      for (int i = 0; i < brandList.length; i++) {
        String name = brandList.elementAt(i);
        if (name.toLowerCase().contains(searchBrandText.toLowerCase())) {
          _brandList.add(name);
          _selectedBrandList.add(selectedBrandList[i]);
        }
      }
      return List.generate(
        _brandList.length,
        (index) => MyCheckBox(
          isDarkMode: _isDarkMode,
          value: _selectedBrandList[index],
          onChanged: () {
            setState(() {
              _selectedBrandList[index] = !_selectedBrandList[index];
            });
          },
          label: _brandList[index],
        ),
      );
    }
  }

  void applyFilter() {
    Navigator.pop(context);
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onChanged,
    required this.hint,
    required this.isDarkMode,
    this.onVisibilityChanged,
    this.textEditingController,
  }) : super(key: key);

  final bool isDarkMode;
  final void Function(String) onChanged;
  final String hint;
  final void Function()? onVisibilityChanged;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    final _greyColor = isDarkMode ? greyColorDark : greyColor;
    late final Color _textColor;

    _textColor = _greyColor;

    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      controller: textEditingController,
      style: TextStyle(
        fontSize: 14,
        color: _textColor,
      ),
      decoration: InputDecoration(
        hintText: this.hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: _greyColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: _greyColor,
          size: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        isDense: true,
        prefixIconConstraints: BoxConstraints.tight(Size(32, 24)),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
      ),
    );
  }
}
