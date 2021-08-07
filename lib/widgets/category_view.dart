import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/text_styles.dart';
import 'package:neel_a/data/category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key, required this.categoryData,required this.color}) : super(key: key);

  final CategoryData categoryData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      width: 50 + 16 * 2,
      color: color,
      child: Column(
        children: [
          Image.asset(
            categoryData.imgURL,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            categoryData.name,
            style: textStyle10,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}