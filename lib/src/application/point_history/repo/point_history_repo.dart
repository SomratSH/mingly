import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointHistoryRepo {
  Future<Map<String, dynamic>> getPointHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.pointHistory,
      authToken: preferences.getString("authToken"),
    );
    if (response.isNotEmpty) {
      return response;
    }
    return response;
  }
}
