import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/data/category.dart';
import 'package:neel_a/widgets/category_view.dart';

class HomeCategoryListWidget extends StatelessWidget {
  const HomeCategoryListWidget({Key? key, required this.categoryList,required this.textSize,required this.color})
      : super(key: key);

  final List<CategoryData> categoryList;
  final double textSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    final _greyColor0 = isDarkMode ? (greyColorDark) : greyColor0;
    return Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: _greyColor0),
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
                  'SHOP BY',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode?accentColorDark:greyColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Health Concern',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Find the best remedies for your problem',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 50 + 8 * 3 + textSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 8,
              itemBuilder: (context, index) {
                return CategoryView(categoryData: categoryList[index],color: color,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
