import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/data/gender.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/pages/address_list_page.dart';
import 'package:neel_a/pages/appointment_list_page.dart';
import 'package:neel_a/pages/change_password_page.dart';
import 'package:neel_a/pages/edit_profile_page.dart';
import 'package:neel_a/pages/home_page.dart';
import 'package:neel_a/pages/order_list_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const ID = 'ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      backgroundColor: _bgColor,
      appBar: BaseAppBar(
        title: 'My Account',
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _isDarkMode ? (gradientDarkColor2) : (gradientColor1),
                  _isDarkMode ? (gradientDarkColor1) : (gradientColor2),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Consumer<ProfileModel>(builder: (context, model, child) {
                      return Column(
                        children: [
                          getGenderIcon(model.profileData.gender),
                          SizedBox(height: 8),
                          Text(
                            model.profileData.name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            model.profileData.email,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            model.profileData.number,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: editProfile,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildProfileList(),
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

  Widget _buildProfileList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'MY ORDERS',
            style: TextStyle(
              fontSize: 14,
              color: _greyColor,
            ),
          ),
          SizedBox(height: 8),
          _ProfileListItem(
            isDarkMode: _isDarkMode,
            iconData: Icons.card_giftcard,
            onPressed: () => Navigator.pushNamed(context, OrderListPage.ID),
            title: 'Orders',
            subTitle:
                'View, Track, Change/Cancel, Return/Replace, Download Invoice',
          ),
          SizedBox(height: 16),
          Text(
            'MY CONSULTATION',
            style: TextStyle(
              fontSize: 14,
              color: _greyColor,
            ),
          ),
          SizedBox(height: 8),
          _ProfileListItem(
            isDarkMode: _isDarkMode,
            iconData: Icons.medical_services_outlined,
            onPressed: () =>
                Navigator.pushNamed(context, AppointmentListPage.ID),
            title: 'Consultation',
            subTitle: 'View all your Consultation queries',
          ),
          SizedBox(height: 16),
          Text(
            'PROFILE',
            style: TextStyle(
              fontSize: 14,
              color: _greyColor,
            ),
          ),
          SizedBox(height: 8),
          _ProfileListItem(
            isDarkMode: _isDarkMode,
            iconData: Icons.location_on_outlined,
            onPressed: () => Navigator.pushNamed(context, AddressListPage.ID),
            title: 'Address',
            subTitle: 'Save, Delete & Change Address',
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
          _ProfileListItem(
            isDarkMode: _isDarkMode,
            iconData: Icons.person_outline,
            onPressed: () =>
                Navigator.pushNamed(context, EditProfilePage.ID),
            title: 'Personal Info',
            subTitle: 'View or edit your personal info',
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
          _ProfileListItem(
            isDarkMode: _isDarkMode,
            iconData: Icons.vpn_key,
            onPressed: () =>
                Navigator.pushNamed(context, ChangePasswordPage.ID),
            title: 'Change Password',
            subTitle: 'Change / Reset your password',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ProfileModel>(context,listen: false).logout();
                _logoutPopUp();
              },
              style: ElevatedButton.styleFrom(
                primary: _bgColor,
                onPrimary: _primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: _primaryColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 20,
                  ),
                  Text(
                    'LOGOUT',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logoutPopUp() {
    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        height: 133+24,
        width: _windowWidth-32*2,
        padding: EdgeInsets.all(16),
        color: _containerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Are you sure you want logout?',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            Expanded(child: Container()),
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
                    //Navigator.pop(context);
                    Navigator.popUntil(context, ModalRoute.withName(HomePage.ID));
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

  Widget getGenderIcon(Gender gender) {
    if (gender == Gender.male)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('images/male.png'),
          ),
        ],
      );
    if (gender == Gender.female)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('images/female.png'),
          ),
        ],
      );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('images/male.png'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'OR',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('images/female.png'),
        ),
      ],
    );
  }

  void editProfile() {
    Navigator.pushNamed(context, EditProfilePage.ID);
  }
}

class _ProfileListItem extends StatelessWidget {
  const _ProfileListItem({
    Key? key,
    required this.isDarkMode,
    required this.iconData,
    required this.onPressed,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final bool isDarkMode;
  final IconData iconData;
  final String title, subTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final _containerColor = isDarkMode ? (lightBlack) : whiteColor;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: _containerColor,
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 20,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 12),
                    //maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
