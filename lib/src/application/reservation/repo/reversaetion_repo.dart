import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/favourite/model/favourite_model.dart';
import 'package:mingly/src/application/reservation/model/reservation_model.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReversaetionRepo {
  Future<List<ReservationModel>> getReservation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.reservation,
      authToken: preferences.getString("authToken"),
    );
    return response.map((e) => ReservationModel.fromJson(e)).toList();
  }

  // Future<Map<String, dynamic>> addFavourite(String id) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //    try {
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //     },
  //     body: jsonEncode({}), // send body if needed
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     final data = jsonDecode(response.body);
  //     debugPrint("✅ Added to favourites: $data");
  //   } else {
  //     debugPrint("⚠️ Failed (${response.statusCode}): ${response.body}");
  //   }
  // } catch (e) {
  //   debugPrint("❌ Error: $e");
  // }
}
