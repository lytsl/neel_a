import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/theme.dart';
import 'package:neel_a/data/gender.dart';
import 'package:neel_a/data/profile.dart';
import 'package:neel_a/model/home_model.dart';
import 'package:neel_a/pages/add_address_page.dart';
import 'package:neel_a/pages/address_list_page.dart';
import 'package:neel_a/pages/booking_success_page.dart';
import 'package:neel_a/pages/cart_page.dart';
import 'package:neel_a/pages/consult_doctor_page.dart';
import 'package:neel_a/pages/doctor_list.dart';
import 'package:neel_a/pages/edit_profile_page.dart';
import 'package:neel_a/pages/filter_page.dart';
import 'package:neel_a/pages/home_page.dart';
import 'package:neel_a/pages/patient_details_page.dart';
import 'package:neel_a/pages/product_list_page.dart';
import 'package:neel_a/pages/profile_page.dart';
import 'package:neel_a/pages/search_page.dart';
import 'package:neel_a/pages/sign_in_page.dart';
import 'package:neel_a/pages/sign_up_page.dart';
import 'package:neel_a/pages/sign_with_mobile_page.dart';
import 'package:neel_a/pages/wish_list_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/constants.dart';
import 'model/profile_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(ProfileDataAdapter());
  await Hive.openBox<ProfileData>(ProfileData.ID);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final hour = DateTime.now().hour;
    final initTheme = (hour>=6 && hour<=6+12)?lightTheme:darkTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
        ChangeNotifierProvider<ProfileModel>(create: (context) => ProfileModel()),
      ],
      child: ThemeProvider(
        duration: navigationDuration,
        initTheme: initTheme,
        builder: (context,myTheme){
          return  MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Neel Ayurvedics',
              theme: myTheme,
              //darkTheme: darkTheme,
              //home: HomePage(),
              initialRoute: HomePage.ID,
              routes: {
                HomePage.ID: (context) => HomePage(),
              },
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case HomePage.ID:
                    return PageTransition(
                      child: HomePage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case SignWithMobilePage.ID:
                    return PageTransition(
                      child: SignWithMobilePage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case SignUpPage.ID:
                    return PageTransition(
                      child: SignUpPage(number: settings.arguments as String,),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case SignInPage.ID:
                    return PageTransition(
                      child: SignInPage(number: settings.arguments as String,),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case ProfilePage.ID:
                    return PageTransition(
                      child: ProfilePage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case EditProfilePage.ID:
                    return PageTransition(
                      child: EditProfilePage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case ProductListPage.ID:
                    return PageTransition(
                      child: ProductListPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case CartPage.ID:
                    return PageTransition(
                      child: CartPage(fromWishList: (settings.arguments as bool?) ?? false),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case WishListPage.ID:
                    return PageTransition(
                      child: WishListPage(fromCartPage: (settings.arguments as bool?) ?? false),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case FilterPage.ID:
                    return PageTransition(
                      child: FilterPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case SearchPage.ID:
                    return PageTransition(
                      child: SearchPage(),
                      type: PageTransitionType.bottomToTop,
                      duration: navigationDuration,
                    );
                  case AddressListPage.ID:
                    return PageTransition(
                      child: AddressListPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case AddAddressPage.ID:
                    return PageTransition(
                      child: AddAddressPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case ConsultDoctorPage.ID:
                    return PageRouteBuilder(
                        transitionDuration: navigationDuration1,
                        pageBuilder: (_, __, ___) => ConsultDoctorPage(doctorName:settings.arguments as String),
                    );
                  case DoctorListPage.ID:
                    return PageTransition(
                      child: DoctorListPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case PatientDetailsPage.ID:
                    return PageTransition(
                      child: PatientDetailsPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                  case BookingSuccessPage.ID:
                    return PageTransition(
                      child: PatientDetailsPage(),
                      type: PageTransitionType.fade,
                      duration: navigationDuration,
                    );
                }
              });
        },
      ),
    );
  }
}
