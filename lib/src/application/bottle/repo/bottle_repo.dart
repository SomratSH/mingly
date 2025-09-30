import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/bottle/model/bottle_model.dart';
import 'package:mingly/src/constant/app_urls.dart';

class BottleRepo {
  Future<List<BottleModel>> getBottle() async {
    final response = await ApiService().getList(AppUrls.getBottle);
    return response.map((e) => BottleModel.fromJson(e)).toList();
  }
}
