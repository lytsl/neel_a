import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/data/category.dart';
import 'package:neel_a/widgets/category_view.dart';

class HomeCategoryGridWidget extends StatelessWidget {
  const HomeCategoryGridWidget({Key? key, required this.categoryList,required this.textSize,required this.windowWidth,required this.color})
      : super(key: key);

  final List<CategoryData> categoryList;
  final double windowWidth,itemCount = 8,textSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    final _greyColor0 = isDarkMode ? (greyColorDark) : greyColor0;
    return Container(
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: _greyColor0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: ((windowWidth-16*4)/4)/(50 + 8 * 3 + textSize),
            ),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return CategoryView(categoryData: categoryList[index],color: color,);
            },
          ),
        ],
      ),
    );
  }
}
