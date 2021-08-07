import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/data/gender.dart';
import 'package:neel_a/data/profile.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/base_app_bar.dart';
import 'package:neel_a/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static const ID = 'EditProfilePage';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late bool _isDarkMode;
  late Color _containerColor;
  String? email, name;
  Gender? gender;
  String? nickName;

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Fun.isDarkMode(context);
    _containerColor = _isDarkMode ? (lightBlack) : whiteColor;

    return Scaffold(
        backgroundColor: _isDarkMode ? bgColorDark : bgColor,
        appBar: BaseAppBar(
          title: 'Personal Info',
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                56,
            child: Consumer<ProfileModel>(builder: (context, model, child) {
              if(gender == null)
                gender = model.profileData.gender;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
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
                    child: getGenderIcon(),
                  ),
                  Container(
                    color: _containerColor,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        MyTextField(
                          onChanged: (v) => email = v,
                          hint: 'Email',
                          isDarkMode: _isDarkMode,
                          textEditingController: TextEditingController()
                            ..text = model.profileData.email,
                        ),
                        SizedBox(height: 16),
                        MyTextField(
                          onChanged: (v) {},
                          hint: 'Mobile No.',
                          isDarkMode: _isDarkMode,
                          isEnabled: false,
                          textEditingController: TextEditingController()
                            ..text = model.profileData.number,
                        ),
                        SizedBox(height: 16),
                        MyTextField(
                          onChanged: (v) => name = v,
                          hint: 'Name',
                          isDarkMode: _isDarkMode,
                          textEditingController: TextEditingController()
                            ..text = model.profileData.name,
                        ),
                        SizedBox(height: 16),
                        MyTextField(
                          onChanged: (v) => nickName = v,
                          hint: 'Nick Name',
                          isDarkMode: _isDarkMode,
                          textEditingController:
                              (model.profileData.nickName == null)
                                  ? (null)
                                  : (TextEditingController()
                                    ..text = model.profileData.nickName!),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: elevatedButtonCorner.copyWith(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12)),
                      ),
                      onPressed: () => savePersonalInfo(model),
                      child: Text('SAVE PERSONAL INFO'),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }

  void savePersonalInfo(ProfileModel model) {
    if ((name == null) &&
        (email == null) &&
        (gender == model.profileData.gender) &&
        (nickName == null)) {
      Fun.toast('Please edit info before saving');
      return;
    }
    ProfileData data = ProfileData(
        number: model.profileData.number,
        name: name ?? model.profileData.name,
        email: email ?? model.profileData.email,
        nickName: nickName,
        gender: gender ?? model.profileData.gender,
    );
    model.editProfile(data);
    Navigator.pop(context);
  }

  Widget getGenderIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (gender != Gender.male) {
                      setState(() {
                        gender = Gender.male;
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/male.png'),
                  ),
                ),
                Visibility(
                  visible: (gender == Gender.male),
                  child: Positioned(
                    bottom: 4,
                    right: 4,
                    child: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: _isDarkMode ? primaryColorDark : primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.done,
                            size: 12,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Male',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
        SizedBox(width: 32),
        Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (gender != Gender.female) {
                      setState(() {
                        gender = Gender.female;
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/female.png'),
                  ),
                ),
                Visibility(
                  visible: (gender == Gender.female),
                  child: Positioned(
                    bottom: 4,
                    right: 4,
                    child: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: _isDarkMode ? primaryColorDark : primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.done,
                            size: 12,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Female',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
      ],
    );
  }

}
