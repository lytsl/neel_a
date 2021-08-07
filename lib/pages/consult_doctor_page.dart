import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/constants/theme.dart';
import 'package:neel_a/pages/patient_details_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/my_container.dart';

class ConsultDoctorPage extends StatefulWidget {
  const ConsultDoctorPage({
    Key? key,
    required this.doctorName,
  }) : super(key: key);

  static const ID = 'ConsultDoctorPage';
  static const DOCTOR_HERO = 'DoctorHeroTag';

  final String doctorName;

  @override
  _ConsultDoctorPageState createState() => _ConsultDoctorPageState();
}

class _ConsultDoctorPageState extends State<ConsultDoctorPage> {
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

  late DateTime todayDate, lastDate, selectedDate;

  final List<String> timeList = ['9-10', '10-11', '11-12'];
  int selectedTimeIndex = -1;

  @override
  Widget build(BuildContext context) {
    buildInit();

    return Scaffold(
      //appBar: _buildAppBar(context),
      backgroundColor: _containerColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        color: _greyColor0,
                        width: double.infinity,
                        child: Center(
                          child: Hero(
                            tag: ConsultDoctorPage.DOCTOR_HERO + widget.doctorName,
                            child: Image.asset(
                              'images/doctor.png',
                              height: _windowHeight*(0.25),
                              width: _windowHeight*(0.25),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: _greyColor0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            color: _containerColor,
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Dates Available',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Theme(
                                data: _isDarkMode?darkTheme.copyWith(
                                  //primaryColor: _primaryColor,
                                  colorScheme: ColorScheme.dark(
                                    primary: _primaryColor,
                                  ),
                                ):lightTheme.copyWith(
                                  //primaryColor: _primaryColor,
                                  colorScheme: ColorScheme.light(
                                    primary: _primaryColor,
                                  ),
                                ),
                                child: CalendarDatePicker(
                                  initialDate: todayDate,
                                  firstDate: todayDate,
                                  lastDate: lastDate,
                                  onDateChanged: (date) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: _textHeight12 + 8 * 2,
                                child: ListView.builder(
                                  itemCount: timeList.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(selectedTimeIndex!=index){
                                            setState(() {
                                              selectedTimeIndex = index;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          //border: Border.all(color: _greyColor0),
                                          color: (selectedTimeIndex == index)
                                              ? _accentColor
                                              : _greyColor1,
                                        ),
                                        child: Text(
                                          timeList[index],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: (selectedTimeIndex == index)
                                                ? Colors.white
                                                : _greyColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              //Expanded(child: Container()),
                              //SizedBox(height: 16),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        primary: _primaryColor,
                        elevation: 0,
                        //tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(8),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: iconSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: bookAppointment,
                style: ElevatedButton.styleFrom(
                    primary: (selectedTimeIndex!=-1)?_accentColor:_greyColor,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                ),
                child: Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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

    todayDate = DateTime.now();
    lastDate = todayDate.add(Duration(days: 90));
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

  void bookAppointment() {
    if(selectedTimeIndex==-1){
      Fun.toast('Please select time before continuing');
      return;
    }
    Navigator.pushNamed(context, PatientDetailsPage.ID);
  }
}
