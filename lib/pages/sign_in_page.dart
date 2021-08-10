import 'dart:async';

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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.number}) : super(key: key);

  static const ID = 'SignInPage';

  final String number;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late bool isDarkMode;
  late Color _greyColor;
  late double windowWidth, textSize12;

  String password = '', otp = '';
  bool isPassVisible = false;
  bool signingWithPassword = true;

  @override
  Widget build(BuildContext context) {
    isDarkMode = (ThemeProvider.of(context)!.brightness == Brightness.dark);
    windowWidth = MediaQuery.of(context).size.width;
    _greyColor = isDarkMode ? greyColorDark : greyColor;
    textSize12 = Fun.textHeight(12, context);

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
                                'Sign In',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Login to get a better shopping experience',
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
                            style: TextStyle(
                              fontSize: 14,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      (signingWithPassword)
                          ? MyTextField(
                              hint: 'Password',
                              isDarkMode: isDarkMode,
                              onChanged: (v) => this.password = v,
                              textInputType: TextInputType.visiblePassword,
                              isPasswordVisible: this.isPassVisible,
                              onVisibilityChanged: onPassVisibilityChanged,
                            )
                          : OTPField(
                              textInputAction: TextInputAction.done,
                              onChanged: onOTPChanged,
                              hint: 'OTP',
                              isDarkMode: isDarkMode,
                              textSize12: textSize12,
                            ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: switchLoginMethod,
                          child: Text(
                            (signingWithPassword)
                                ? 'Login with OTP'
                                : 'Login with Password',
                            style: TextStyle(
                              fontSize: 12,
                              height: 0.5,
                              color: _greyColor,
                            ),
                          ),
                        ),
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
                      SizedBox(height: 32),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: switchLoginMethod,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              height: 0.5,
                              color: _greyColor,
                            ),
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

  void onCancel() {
    Navigator.of(context).popUntil(ModalRoute.withName(HomePage.ID));
  }

  void switchLoginMethod() {
    setState(() {
      signingWithPassword = !signingWithPassword;
    });
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void onPassVisibilityChanged() {
    setState(() {
      isPassVisible = !isPassVisible;
    });
  }

  void onContinue() {
    if (signingWithPassword && password.length == 0) {
      Fun.toast('Password is Empty');
      return;
    }
    if (!signingWithPassword && otp.length == 0) {
      Fun.toast('OTP is Empty');
      return;
    }
    Provider.of<ProfileModel>(context, listen: false).setProfile(
      ProfileData(
        number: widget.number,
        name: 'name',
        email: 'email',
      ),
    );
    //Navigator.pushNamed(context, ProfilePage.ID);
    Navigator.pushNamedAndRemoveUntil(
        context, ProfilePage.ID, ModalRoute.withName(HomePage.ID));
  }

  void onOTPChanged(String value) {}
}

class OTPField extends StatefulWidget {
  const OTPField({
    Key? key,
    required this.onChanged,
    required this.hint,
    required this.isDarkMode,
    required this.textSize12,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final bool isDarkMode;
  final void Function(String) onChanged;
  final String hint;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final double textSize12;

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  Timer? _timer;
  int _start = 10;

  void startTimer() {
    if (_start == 0) FocusScope.of(context).unfocus();
    _start = 10;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (this.mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (this.mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _greyColor = widget.isDarkMode ? greyColorDark : greyColor;
    final _accentColor = widget.isDarkMode ? accentColorDark : accentColor;

    return TextField(
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 8,
      ),
      decoration: InputDecoration(
        labelText: this.widget.hint,
        labelStyle: TextStyle(
          fontSize: 14,
          color: _greyColor,
        ),
        suffixIcon: (_start == 0)
            ? TextButton(
                onPressed: startTimer,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                ),
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 12,
                    height: 0,
                    color: _accentColor,
                  ),
                ),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                ),
                onPressed: () {},
                child: Text(
                  _start.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    height: 0,
                    color: _accentColor,
                  ),
                ),
              ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        isDense: true,
        suffixIconConstraints:
            BoxConstraints.tightFor(height: widget.textSize12 + 4),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
