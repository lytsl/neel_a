import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/pages/consult_doctor_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_container.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  static const ID = 'DoctorListPage';

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
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

  final doctorList = ['Dr. Ketna Desai', 'Dr. Rupa D Unadkat'];

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: _bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()=>navigateToConsultDoctor(doctorList[index]),
              child: MyContainer(
                isDarkMode: _isDarkMode,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorList[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ayurvedic Doctor',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Hero(
                      tag: ConsultDoctorPage.DOCTOR_HERO + doctorList[index],
                      child: Image.asset(
                        'images/doctor.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
        'Book a Doctor',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      centerTitle: false,
    );
  }

  void navigateToConsultDoctor(String doctor) {
    Navigator.pushNamed(context, ConsultDoctorPage.ID,arguments: doctor,);
  }
}
