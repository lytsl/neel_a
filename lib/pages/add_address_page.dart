import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_text_field.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  static const ID = 'AddAddressPage';

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
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

  String? name,
      number,
      alternateNumber,
      pinCode,
      address1,
      address2,
      address3,
      city,
      state = '-- Select State --';

  final stateList = [
    '-- Select State --',
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.name = v,
                    hint: 'Name*',
                    isDarkMode: _isDarkMode,
                    textInputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.number = v,
                    hint: 'Mobile*',
                    isDarkMode: _isDarkMode,
                    textInputType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Alternate Mobile',
                    isDarkMode: _isDarkMode,
                    textInputType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  thickness: 4,
                  color: _greyColor1,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Pin Code*',
                    textInputType: TextInputType.number,
                    isDarkMode: _isDarkMode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Flat / House No., Building / Company*',
                    isDarkMode: _isDarkMode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Road Name, Street, Area, Colony*',
                    isDarkMode: _isDarkMode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Landmark (Optional)',
                    isDarkMode: _isDarkMode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyTextField(
                    onChanged: (v) => this.alternateNumber = v,
                    hint: 'Town/City*',
                    isDarkMode: _isDarkMode,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButton<String>(
                      /*hint: Text(
                        'Select State',
                        style: TextStyle(fontSize: 14),
                      ),*/
                    underline: Divider(thickness: 1,color: _greyColor,height: 8,),
                      value: this.state,
                      menuMaxHeight: _windowHeight*(0.75),
                      //isDense : true,
                      isExpanded: true,
                      onChanged: (s){
                        setState(() {
                          this.state = s;
                        });
                      },
                      items: stateList
                          .map(
                            (state) => DropdownMenuItem<String>(
                              value: state,
                              child: Text(
                                state,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                          .toList()),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: _greyColor1,
            height: 0,
          ),
          Container(
            color: _containerColor,
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _containerColor,
                      onPrimary: _textColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: navigateBack,
                    child: Text('CANCEL',style: TextStyle(fontSize: 12),),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _accentColor,
                      //onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: saveAddress,
                    child: Text('SAVE ADDRESS',style: TextStyle(fontSize: 12,color: Colors.white),),
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

  void saveAddress() {
    Navigator.pop(context);
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
