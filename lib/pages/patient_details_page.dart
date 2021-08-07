import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({Key? key}) : super(key: key);

  static const ID = 'PatientDetailsPage';

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
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
      email,
      description;

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProfileModel>(
              builder: (context, model,child) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: MyTextField(
                        onChanged: (v) => this.name = v,
                        hint: 'Name*',
                        isDarkMode: _isDarkMode,
                        textInputType: TextInputType.name,
                        textEditingController: TextEditingController()..text = model.profileData.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: MyTextField(
                        onChanged: (v) => this.number = v,
                        hint: 'Mobile*',
                        isDarkMode: _isDarkMode,
                        textInputType: TextInputType.phone,
                        textEditingController: TextEditingController()..text = model.profileData.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: MyTextField(
                        onChanged: (v) => this.email = v,
                        hint: 'Email*',
                        isDarkMode: _isDarkMode,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        textEditingController: TextEditingController()..text = model.profileData.email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: MyTextField(
                        onChanged: (v) => this.description = v,
                        hint: 'Description',
                        isDarkMode: _isDarkMode,
                      ),
                    ),

                  ],
                );
              }
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
                    onPressed: bookAppointment,
                    child: Text('NEXT',style: TextStyle(fontSize: 12,color: Colors.white),),
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
        'Personal Information',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
    );
  }

  void bookAppointment() {
    if(name!=null && name!.length == 0){
      Fun.toast('Name cannot be empty');
      return;
    }
    if(email!=null && email!.length == 0){
      Fun.toast('Name cannot be empty');
      return;
    }
    if(number!=null && number!.length != 10){
      Fun.toast('Mobile Number must be 10 digit long');
      return;
    }

    Fun.snackBar('Booking was successful', context);

  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
