import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/constants/size.dart';
import 'package:neel_a/constants/string_constants.dart';
import 'package:neel_a/constants/text_styles.dart';
import 'package:neel_a/constants/theme.dart';
import 'package:neel_a/data/category.dart';
import 'package:neel_a/model/home_model.dart';
import 'package:neel_a/model/profile_model.dart';
import 'package:neel_a/pages/cart_page.dart';
import 'package:neel_a/pages/doctor_list.dart';
import 'package:neel_a/pages/product_list_page.dart';
import 'package:neel_a/pages/profile_page.dart';
import 'package:neel_a/pages/search_page.dart';
import 'package:neel_a/pages/sign_with_mobile_page.dart';
import 'package:neel_a/utility/functions.dart';
import 'package:neel_a/widgets/category_view.dart';
import 'package:neel_a/widgets/custom_modal_sheet.dart';
import 'package:neel_a/widgets/home_category_grid_widget.dart';
import 'package:neel_a/widgets/home_category_list_widget.dart';
import 'package:neel_a/widgets/home_covid_list.dart';
import 'package:neel_a/widgets/home_details_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const ID = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late double textSize12, textSize10, windowHeight, windowWidth;
  late bool isDarkMode;
  late Color _containerColor;
  final sliderRatio = (910 / 460);

  late AnimationController _controller;
  late BorderRadiusTween borderRadius;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  double min = 0.5, initial = 0.75, max = 1;
//double _height;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(8.0),
      end: BorderRadius.circular(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildInit();

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
            return ListView(
              children: [
                //category list
                SizedBox(
                  height: 50 + 8 * 3 + textSize12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: model.categoryList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: navigateToCategoryProducts,
                        child: CategoryView(
                            categoryData: model.categoryList[index], color: _containerColor,),
                      );
                    },
                  ),
                ),

                //image slider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: windowWidth * (0.85) / sliderRatio,
                      aspectRatio: sliderRatio,
                      viewportFraction: 0.81,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: model.sliderImageList.map((uri) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                uri,
                                fit: BoxFit.cover,
                                width: windowWidth * (0.85),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),

                //consult a doctor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: _containerColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('images/consult_doctor.png'),
                          width: windowWidth * (0.35),
                          height: windowWidth * (0.35) * (4 / 5),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                'Looking for Consultation?'.toUpperCase(),
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: accentColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ask a doctor',
                                maxLines: 2,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Get free consultation from our experienced doctors online',
                                maxLines: 4,
                                style: TextStyle(fontSize: 11),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: consultDoctor,
                                style: elevatedButtonCorner,
                                child: Text(
                                  'CONSULT NOW',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                //shop by
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeCategoryGridWidget(
                    color: _containerColor,
                    categoryList: model.categoryList,
                    windowWidth: windowWidth,
                    textSize: textSize12,
                  ),
                ),
                SizedBox(height: 16),

                //covid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeCovidListWidget(color: _containerColor),
                ),
                SizedBox(height: 16),


                //the real deal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/categories0.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'The Real Deal',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Save more with exciting offers and discounts',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepPurple,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: consultDoctor,
                          style: elevatedButtonRounded,
                          child: Text(
                            'EXPLORE NOW',
                            style: TextStyle(
                              fontSize: 11,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                //featured zone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeCategoryListWidget(
                    color: _containerColor,
                    categoryList: model.categoryList,
                    textSize: textSize12,
                  ),
                ),
                SizedBox(height: 16),

                //super savings
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'SUPER SAVINGS',
                    style: TextStyle(fontSize: 14, color: isDarkMode?greyColorDark:greyColor),
                  ),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeDetailsList(
                    windowWidth: windowWidth,
                    textSize: textSize10,
                  ),
                ),
                SizedBox(height: 16),

                //exclusive zone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeCategoryListWidget(
                    color: _containerColor,
                    categoryList: model.categoryList,
                    textSize: textSize12,
                  ),
                ),
                SizedBox(height: 16),

                //featured zone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeCategoryListWidget(
                    color: _containerColor,
                    categoryList: model.categoryList,
                    textSize: textSize12,
                  ),
                ),
                SizedBox(height: 16),

                //quality you can trust
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'QUALITY YOU CAN TRUST',
                    style: TextStyle(fontSize: 14, color: isDarkMode?greyColorDark:greyColor),
                  ),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HomeDetailsList(
                    windowWidth: windowWidth,
                    textSize: textSize10,
                  ),
                ),
                SizedBox(height: 16),

                //reader zone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: _containerColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'READER ZONE',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDarkMode?accentColorDark:greyColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Health Guide',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Reveal the secrets for a health life',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: windowWidth * (0.5) / sliderRatio + textSize10*2 + 8*3 +8,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                width: windowWidth * (0.5) + 8,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: Image.asset(
                                        (index == 2)
                                            ? 'images/slider$index.jpg'
                                            : 'images/slider$index.png',
                                        fit: BoxFit.cover,
                                        width: windowWidth * (0.5),
                                        height: windowWidth * (0.5) / sliderRatio,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'All about General Tonics  for a Healthier Life!',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isDarkMode?greyColorDark:greyColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),

                //quote
                Center(
                  child: Container(
                    color: greyColor,
                    height: 2,
                    width: 100,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'I believe that the greatest gift you can give your family and the world is a healthy you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode?greyColorDark:greyColor,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    '- Joyce Meyer -',
                    style: GoogleFonts.sail(
                      textStyle: TextStyle(
                        color: isDarkMode?greyColorDark:greyColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }

  void buildInit() {
    textSize12 = Fun.textHeight(12, context);
    textSize10 = Fun.textHeight(10, context);
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    isDarkMode = ThemeProvider.of(context)!.brightness == Brightness.dark;
    print('isDarkMode');
    print(isDarkMode);
    _containerColor = isDarkMode?(lightBlack):whiteColor;
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      //backgroundColor: primaryColor,
      //brightness: MediaQuery.of(context).platformBrightness,
      elevation: 0,
      titleSpacing: 0,

      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: iconColor,
          size: iconSize,
        ),
        onPressed: showMenuBottomSheet,
      ),
      title: Text(
        'Neel Ayurvedics',
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 8),
          constraints: BoxConstraints(),
          onPressed: navigateToShopping,
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: iconColor,
            size: iconSize,
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(right: 8),
          constraints: BoxConstraints(),
          onPressed: navigateToProfile,
          icon: Icon(
            Icons.person_outline,
            color: iconColor,
            size: iconSize,
          ),
        ),
        ThemeSwitcher(
          builder: (context) {
            return IconButton(
              padding: EdgeInsets.only(right: 16),
              constraints: BoxConstraints(),
              onPressed: () {
                print(ThemeProvider.of(context)!.brightness ==
                    Brightness.light);
                ThemeSwitcher.of(context)!.changeTheme(
                    theme: ThemeProvider.of(context)!.brightness ==
                        Brightness.light
                        ? darkTheme
                        : lightTheme,
                    reverseAnimation: false // default: false
                );
              },
              icon: Icon(
                ThemeProvider.of(context)!.brightness == Brightness.light
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
                size: iconSize,
                color: iconColor,
              ),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40 + 8),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: GestureDetector(
            onTap: navigateToSearch,
            child: Container(
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: isDarkMode?bgColorDark:whiteColor,
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: isDarkMode?whiteColor:greyColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        searchString,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode?whiteColor:greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMenuBottomSheet() {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: windowHeight * (0.75),
      ),
      containerWidget: (_, animation, child) {
        print(animation.value);
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: isDarkMode?bgColorDark:whiteColor,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12),
              child: child,
            ),
          ),
        );
      },
      expand: false,
    );
    /*CustomModalSheet.show(
      context: context,
      child: Container(
        height: windowHeight * (0.75),
        width: windowWidth,

      ),
    );*/
  }

  void consultDoctor() {
    Navigator.pushNamed(context, DoctorListPage.ID);
  }

  void navigateToShopping() {
    Navigator.pushNamed(context, CartPage.ID);
  }

  void navigateToProfile() {
    if(Provider.of<ProfileModel>(context,listen: false).hasLoggedIn)
      Navigator.pushNamed(context, ProfilePage.ID);
    else
      Navigator.pushNamed(context, SignWithMobilePage.ID);
  }

  void navigateToCategoryProducts() {
    Navigator.pushNamed(context, ProductListPage.ID);
  }

  void navigateToSearch() {
    Navigator.pushNamed(context, SearchPage.ID);
  }
}

