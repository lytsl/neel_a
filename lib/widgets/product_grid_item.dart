import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.windowWidth,
    required this.isDarkMode,
    required this.textHeight14,
    required this.textHeight12,
    required this.onCartClicked,
    required this.isInCart,
    required this.isFavourite,
    required this.onFavorite,
  }) : super(key: key);

  final double windowWidth, textHeight14, textHeight12;
  final bool isDarkMode, isInCart, isFavourite;
  final void Function() onCartClicked,onFavorite;

  @override
  Widget build(BuildContext context) {
    double _size = (windowWidth - 8 * 4 - 8) / 2;
    final _greyColor1 = isDarkMode?greyColorDark:greyColor1;
    final _greyColor0 = isDarkMode?greyColorDark:greyColor0;
    final _greyColor = isDarkMode?greyColorDark:greyColor;
    final _primaryColor =  isDarkMode ? (primaryColorDark) : primaryColor;
    return GridTile(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: isDarkMode ? Colors.transparent : greyColor0, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/product1.jpg',
                  height: _size,
                  width: _size,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: onFavorite,
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.favorite,
                      size: 20,
                      color: isFavourite?Colors.red:_greyColor1,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              height: textHeight14 * 2,
              child: Text(
                'Evion Capsule(400mg) (10caps)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: textHeight12 * 2,
              child: Text(
                'Assists in managing the levels of Vitamin E in',
                style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? (greyColorDark) : greyColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 4),
            RatingBarIndicator(
              rating: 4.5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: isDarkMode ? accentColorDark : accentColor,
              ),
              unratedColor: isDarkMode ? greyColorDark : greyColor,
              itemCount: 5,
              itemSize: 12.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 8),
            SizedBox(
              height: textHeight12,
              child: Text(
                '32',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? (greyColorDark) : greyColor,
                  decoration: TextDecoration.lineThrough,
                ),
                maxLines: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '27',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '16% Off',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? (greyColorDark) : greyColor,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: onCartClicked,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 16,
                    color: isInCart?Colors.white:_greyColor,
                  ),
                  style: elevatedButtonRounded.copyWith(
                    backgroundColor: MaterialStateProperty.all(isInCart?_primaryColor:_greyColor0),
                    padding: MaterialStateProperty.all(EdgeInsets.all(6)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
