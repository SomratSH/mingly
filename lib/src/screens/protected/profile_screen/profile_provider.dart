import 'dart:io';

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

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? address,
    File? image,
  }) async {
    final response = await ProfileRepo().updateProfile({
      "full_name": name,
      "address": address,
      "mobile": phone,
    }, image);
    if (response.isNotEmpty) {
      profileModel.data!.fullName = name;
      profileModel.data!.mobile = phone;
      notifyListeners();
      getProfile();
    } else {
      notifyListeners();
      debugPrint("Failed to update profile");
    }
    return response;
  }
}
