import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/data/profile.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/pages/home_page.dart';
import 'package:neel_a/pages/profile_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key,required this.number}) : super(key: key);

  static const ID = 'SignUpPage';

  final String number;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late bool isDarkMode;
  late Color _greyColor;
  late double windowWidth;

  String email = '', name = '', password = '', confirmPassword = '';
  bool isPassVisible = false;

  @override
  Widget build(BuildContext context) {
    isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    windowWidth = MediaQuery.of(context).size.width;
    _greyColor = isDarkMode ? greyColorDark : greyColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                color: isDarkMode ? primaryColorDark : primaryColor,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Neel Ayurvedics',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 24,
                            color: whiteColor,
                          ),
                          onPressed: onCancel,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: windowWidth - 16 * 3 - 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Fill in your basic details',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Image.asset(
                          'images/sign_logo.png',
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      //SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile',
                                style: TextStyle(
                                  fontSize: 10,
                                  height: 0.5,
                                  color: _greyColor,
                                ),
                              ),
                              TextButton(
                                onPressed: onBackPressed,
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 0.5,
                                    color: _greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.number,
                            style: TextStyle(fontSize: 14,height: 0.5,),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      MyTextField(
                        isDarkMode: isDarkMode,
                        hint: 'Email',
                        onChanged: (v) => this.email = v,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      MyTextField(
                        hint: 'Name',
                        isDarkMode: isDarkMode,
                        onChanged: (v) => this.name = v,
                      ),
                      SizedBox(height: 16),
                      MyTextField(
                        hint: 'Password',
                        isDarkMode: isDarkMode,
                        onChanged: (v) => this.password = v,
                        textInputType: TextInputType.visiblePassword,
                        isPasswordVisible: this.isPassVisible,
                        onVisibilityChanged: onPassVisibilityChanged,
                      ),
                      SizedBox(height: 16),
                      MyTextField(
                        hint: 'Confirm Password',
                        isDarkMode: isDarkMode,
                        onChanged: (v) => this.confirmPassword = v,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        isPasswordVisible: this.isPassVisible,
                        onVisibilityChanged: onPassVisibilityChanged,
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: elevatedButtonCorner.copyWith(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                          onPressed: onContinue,
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(fontSize: 14, color: whiteColor),
                          ),
                        ),
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

  void onCancel(){
    Navigator.of(context).popUntil(ModalRoute.withName(HomePage.ID));
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void onPassVisibilityChanged(){
    setState(() {
      isPassVisible = !isPassVisible;
    });
  }

  void onContinue() {
    if (email.length == 0) {
      Fun.toast('Email is Empty');
      return;
    }
    if (name.length == 0) {
      Fun.toast('Name is Empty');
      return;
    }
    if (password.length == 0) {
      Fun.toast('Password is Empty');
      return;
    }
    if (confirmPassword.length == 0) {
      Fun.toast('Confirm Password is Empty');
      return;
    }
    if (confirmPassword != password) {
      Fun.toast('Password and Confirm Password are not the same');
      return;
    }
    ProfileData data = ProfileData(number: widget.number, name: name, email: email);
    Provider.of<ProfileModel>(context,listen: false).setProfile(data);
    //Navigator.pushNamed(context, ProfilePage.ID);
    Navigator.pushNamedAndRemoveUntil(context, ProfilePage.ID, ModalRoute.withName(HomePage.ID));
  }
}
