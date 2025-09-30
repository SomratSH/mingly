import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/venues/model/venues_model.dart';
import 'package:mingly/src/constant/app_urls.dart';

class VenuesRepo {
  Future<List<VenuesModel>> getVenues() async {
    final response = await ApiService().getList(AppUrls.venuesUrl);
    return response.map((e) => VenuesModel.fromJson(e)).toList();
  }
}
