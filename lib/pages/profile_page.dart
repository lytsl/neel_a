import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/data/gender.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/pages/edit_profile_page.dart';
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

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Fun.isDarkMode(context);

    return Scaffold(
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
            child: Stack(
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
          )
        ],
      ),
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
