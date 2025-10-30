import 'package:flutter/material.dart';
import 'package:mingly/src/application/events/repo/events_repo.dart';
import 'package:mingly/src/application/home/home_repo.dart';
import 'package:mingly/src/application/home/model/adds_image_model.dart';
import 'package:mingly/src/application/home/model/leader_board_model.dart';
import 'package:mingly/src/application/subscription/model/pakage_model.dart';
import 'package:mingly/src/application/subscription/repo/subscription_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeProivder extends ChangeNotifier {
  List<LeaderBoardModel> leaderBoardList = [];
  List<PakageModel> packageList = [];
  String addressUser = "N/A";
  List<AdsImage> addImageList = [
   
  ];



  Future<void> getLeaderBoardlist() async {
    final response = await HomeRepo().getLeaderBoard();
    if (response.isNotEmpty) {
      leaderBoardList = response;
      notifyListeners();
    }
  }

  Future<void> getAdsImagelist() async {
    final response = await HomeRepo().getAdsImage();
    if (response.isNotEmpty) {
      addImageList = response;
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

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return "${place.locality}, ${place.country}";
    } else {
      return "Unknown location";
    }
  }

  Future<void> getCurrentLocationName() async {
    try {
      Position position = await getCurrentLocation();
      String address = await getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );
      addressUser = address;
      notifyListeners();
    } catch (e) {
      "Location not available: $e";
    }
  }

  getHomeData() async {
    await getLeaderBoardlist();
    await getPackagelist();
    await getCurrentLocationName();
  }
}
