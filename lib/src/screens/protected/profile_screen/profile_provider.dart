import 'package:flutter/material.dart';
import 'package:mingly/src/application/profile/model/profile_model.dart';
import 'package:mingly/src/application/profile/repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();

  Future<void> getProfile() async {
    final reseponse = await ProfileRepo().fetchProfile();
    profileModel = reseponse;
    notifyListeners();
  }

  // Future<void> updateProfileData (String name, String phone){
  //   final response =
  // }
}
