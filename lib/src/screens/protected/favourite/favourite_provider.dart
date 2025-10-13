import 'package:flutter/widgets.dart';
import 'package:mingly/src/application/favourite/model/favourite_model.dart';
import 'package:mingly/src/application/favourite/repo/favourite_repo.dart';

class FavouriteProvider extends ChangeNotifier {
  List<FavouriteModel> favouriteList = [];

  Future<void> getFavouriteList() async {
    final response = await FavouriteRepo().getFavourite();
    if (response.isNotEmpty) {
      List<dynamic> data = response;
      for (var e in data) {
        favouriteList.add(e);
      }
      notifyListeners();
    }
  }
}
