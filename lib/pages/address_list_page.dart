import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/pages/add_address_page.dart';
import 'package:neel_a/utility/functions.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  static const ID = 'AddressListPage';

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 8),
            _buildAddLocation(),
            SizedBox(height: 16),
            _buildAddressList(),
          ],
        ),
      ),
    );
  }

  Expanded _buildAddressList() {
    return Expanded(
            child: ListView(
              children: [
                _AddressView(isDarkMode: _isDarkMode, editAddress: (){}, removeAddress: (){}),
              ],
            ),
          );
  }

  SizedBox _buildAddLocation() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: navigateToAddAddress,
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
              Icons.location_on_outlined,
              size: 20,
              color: _textColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Add New Address',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            //SizedBox(width: 8),
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
        'My Address',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
    );
  }

  void navigateToAddAddress() {
    Navigator.pushNamed(context, AddAddressPage.ID);
  }
}

class _AddressView extends StatelessWidget {
  const _AddressView({
    Key? key,
    required this.isDarkMode,
    required this.editAddress,
    required this.removeAddress,
  }) : super(key: key);

  final bool isDarkMode;
  final void Function() removeAddress, editAddress;

  @override
  Widget build(BuildContext context) {
    final _containerColor = isDarkMode ? (lightBlack) : whiteColor;
    final _greyColor0 = isDarkMode ? (greyColorDark) : greyColor0;
    final _greyColor1 = isDarkMode ? (greyColorDark) : greyColor1;
    final _greyColor = isDarkMode ? (greyColorDark) : greyColor;
    final _bgColor = isDarkMode ? (bgColorDark) : bgColor;
    final _accentColor = isDarkMode ? (accentColorDark) : accentColor;
    final _primaryColor = isDarkMode ? (primaryColorDark) : primaryColor;
    final _textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _greyColor0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Container(
                            color: _bgColor,
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 12,
                                color: _greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _accentColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'DEFAULT',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Home number',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Landmark',
                  style: TextStyle(fontSize: 12),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _textColor,
                    ),
                    children: [
                      TextSpan(text: 'City, '),
                      TextSpan(text: 'State - '),
                      TextSpan(text: '123456'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: removeAddress,
                  style: ElevatedButton.styleFrom(
                    primary: _containerColor,
                    onPrimary: _primaryColor,
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: _greyColor0),
                    ),
                  ),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: editAddress,
                  style: ElevatedButton.styleFrom(
                    primary: _containerColor,
                    onPrimary: _primaryColor,
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: _greyColor0),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
