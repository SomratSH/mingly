import 'package:flutter/material.dart';
import 'package:mingly/src/application/events/repo/events_repo.dart';
import 'package:mingly/src/application/home/home_repo.dart';
import 'package:mingly/src/application/home/model/leader_board_model.dart';
import 'package:mingly/src/application/subscription/model/pakage_model.dart';
import 'package:mingly/src/application/subscription/repo/subscription_repo.dart';

class HomeProivder extends ChangeNotifier {
  List<LeaderBoardModel> leaderBoardList = [];
  List<PakageModel> packageList = [];

  Future<void> getLeaderBoardlist() async {
    final response = await HomeRepo().getLeaderBoard();
    if (response.isNotEmpty) {
      leaderBoardList = response;
      notifyListeners();
    }
  }

  Future<void> getPackagelist() async {
    final response = await SubscriptionRepo().getLeaderBoard();
    if (response.isNotEmpty) {
      packageList = response;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> upgradePlanData(
    Map<String, dynamic> data,
  ) async {
    final response = await HomeRepo().updagradePlan(data);
    return response;
  }
}
