import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:neel_a/data/category.dart';

class HomeModel with ChangeNotifier{

  List<String> _sliderImageList = [];
  UnmodifiableListView<String> get sliderImageList => UnmodifiableListView(_sliderImageList);

  List<CategoryData> _categoryList = [];
  UnmodifiableListView<CategoryData> get categoryList => UnmodifiableListView(_categoryList);


  HomeModel(){
    getData();
  }

  void getData(){
    for(int i=0;i<=4;i++)
      _sliderImageList.add('images/slider$i.png');
    _sliderImageList[2] = 'images/slider2.jpg';
    for(int i=0;i<=10;i++)
      _categoryList.add(CategoryData(name: categoryName[i], imgURL: 'images/categories$i.png'));
    //notifyListeners();
  }

  static final List<String> categoryName = ['Deals','Consult','Allopathy','Homeopathy','Ayurveda','Unani','Nutrition & Supplements','Beauty & Personal Care','Health Aid & Fitness','Baby Care','Sexual Wellness'];

}