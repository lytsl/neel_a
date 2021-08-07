import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/pages/sign_in_page.dart';
import 'package:neel_a/pages/sign_up_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SignWithMobilePage extends StatefulWidget {
  const SignWithMobilePage({Key? key}) : super(key: key);

  static const ID = 'SignWithMobilePage';

  @override
  _SignWithMobilePageState createState() => _SignWithMobilePageState();
}

class _SignWithMobilePageState extends State<SignWithMobilePage> {
  late bool isDarkMode;
  late double windowWidth;

  String number = '';
  late TextEditingController phoneController;

  Future<void> getPhoneHint() async {
    final SmsAutoFill _autoFill = SmsAutoFill();
    String? hint = await _autoFill.hint;
    if(hint==null)
      return;
    if(hint.length>10)
      hint = hint.substring(hint.length-10);
    print(hint.length);
    setState(() {
      number = hint!;
      phoneController.value = TextEditingValue(text: hint);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    phoneController = TextEditingController(text: '');
    getPhoneHint();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    windowWidth = MediaQuery.of(context).size.width;
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
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 24,
                            color: whiteColor,
                          ),
                          onPressed: onBackPressed,
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
                                'Sign in / Sign up',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Sign in to access your Orders, Wishlist, Medicines and Offers',
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
                      SizedBox(height: 8),
                      PhoneFieldHint(
                        child: TextField(
                          controller: phoneController,
                          onChanged: (variable) => number = variable,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Email/Mobile',
                            labelStyle: TextStyle(
                                color: isDarkMode ? greyColorDark : greyColor),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: isDarkMode ? greyColorDark : greyColor,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: isDarkMode ? greyColorDark : greyColor,
                              ),
                            ),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(8),
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
                                        horizontal: 16, vertical: 12)),
                          ),
                          onPressed: onContinue,
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(fontSize: 14, color: whiteColor),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'By continuing, you agree to our ',
                            style: TextStyle(
                              fontSize: 12,
                              height: 0.8,
                              color: isDarkMode ? greyColorDark : greyColor,
                            ),
                          ),
                          TextButton(
                            onPressed: onTerms,
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            style: ButtonStyle(
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                          ),
                        ],
                      )
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

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void onContinue() {
    if(number.length!=10){
      print(number);
      print(number.length);
      Fun.toast('Mobile Number must be 10 digit long');
      return;
    }
    //Navigator.pushNamed(context, SignUpPage.ID,arguments: number);
    Navigator.pushNamed(context, SignInPage.ID,arguments: number);
  }

  void onTerms() {}
}
