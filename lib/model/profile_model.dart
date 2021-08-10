import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:neel_a/data/profile.dart';


class ProfileModel with ChangeNotifier{

  late ProfileData _profileData ;
  ProfileData get profileData => _profileData;

  bool _hasLoggedIn = false;
  bool get hasLoggedIn => _hasLoggedIn;

  final Box<ProfileData> box = Hive.box(ProfileData.ID);

  ProfileModel(){
    if(box.isEmpty)
      return;
    _hasLoggedIn = true;
    _profileData = box.getAt(0)!;
  }

  void setProfile(ProfileData data){
    if(box.isEmpty)
      box.add(data);
    else
      box.putAt(0, data);
    _profileData = data;
    _hasLoggedIn = true;
    notifyListeners();
  }

  void editProfile(ProfileData data){
    box.putAt(0, data);
    _profileData = data;
    notifyListeners();
  }

  Future<void> logout() async {
    _hasLoggedIn = false;
    await box.clear();
    notifyListeners();
  }

}