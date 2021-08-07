import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';

class HomeDetailsList extends StatelessWidget {
  const HomeDetailsList(
      {Key? key, required this.windowWidth, required this.textSize})
      : super(key: key);

  final double windowWidth, textSize;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    return SizedBox(
      height: textSize * 7 + 40,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                width: windowWidth * (0.8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: isDarkMode?lightBlack:whiteColor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'images/categories0.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            'MobiKwik CashBack',
                            style: TextStyle(
                              fontSize: 14,
                              //color: greyColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Column(
                            children: List.generate((index==0)?3:2, (i) => _DetailsText(text: 'Get upto Rs.500 CashBack',has: (index!=0),)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '*T&C Apply',
                              style: TextStyle(
                                fontSize: 8,
                                color: isDarkMode?greyColorDark:greyColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Visibility(
                            visible: (index == 0) ? true : false,
                            child: Text(
                              'Offer valid till 31st July,2021',
                              style: TextStyle(fontSize: 10, color: isDarkMode?greyColorDark:greyColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _DetailsText extends StatelessWidget {
  const _DetailsText({Key? key, required this.text, this.has = true})
      : super(key: key);

  final String text;
  final bool has;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = (ThemeProvider.of(context)!.brightness ==
                    Brightness.dark);
    return Row(
      children: [
        Visibility(
          visible: has,
          child: Text(
            '- ',
            style: TextStyle(fontSize: 10, color: isDarkMode?greyColorDark:greyColor),
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 10, color: isDarkMode?greyColorDark:greyColor),
        ),
      ],
    );
  }
}
