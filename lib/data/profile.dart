import 'package:hive/hive.dart';

import 'gender.dart';

part 'profile.g.dart';

@HiveType(typeId: 0)
class ProfileData{
  @HiveField(0)
  final String number;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String email;
  @HiveField(3)
  String? nickName;
  @HiveField(4)
  Gender gender;

  ProfileData({required this.number,required this.name,required this.email,this.nickName,this.gender = Gender.unSelected});

  static const ID = 'ProfileData';

}