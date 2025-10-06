import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/subscription/model/pakage_model.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionRepo {
  Future<List<PakageModel>> getLeaderBoard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.pakageget,
      authToken: preferences.getString("authToken"),
    );
    return response.map((e) => PakageModel.fromJson(e)).toList();
  }
}
