import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/profile/model/profile_model.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  Future<ProfileModel> fetchProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getData(
      AppUrls.profile,
      authToken: preferences.getString("authToken"),
    );
    return ProfileModel.fromJson(reseponse);
  }

  Future<ProfileModel> updateProfile(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().patchData(
      AppUrls.profileUpdate,
      data,
      authToken: preferences.getString("authToken"),
    );
    return ProfileModel.fromJson(reseponse);
  }
}
