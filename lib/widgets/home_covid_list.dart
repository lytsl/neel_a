import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/data/category.dart';
import 'package:neel_a/widgets/category_view.dart';

class HomeCovidListWidget extends StatelessWidget {
  const HomeCovidListWidget({Key? key, required this.color})
      : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage("images/covid_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STAY ALERT! STAY SAFE!',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode?accentColorDark:greyColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'COVID Essential',
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
                //SizedBox(height: 16),
              ],
            ),
          ),

          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset('images/covid0.png',height: 150,width: 150*(4/5),),
                );
              },
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
