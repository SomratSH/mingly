import 'package:flutter/material.dart';
import 'package:mingly/src/application/venues/model/venue_menu_model.dart';
import 'package:mingly/src/application/venues/model/venues_model.dart';
import 'package:mingly/src/application/venues/repo/venues_repo.dart';

class VenueProvider extends ChangeNotifier {
  List<VenuesModel> venuesList = [];
  List<VenuesModel> venuesFeaturedList = [];
  List<VenueMenuModel> venueMenuList = [];

  Future<void> getVenuesList() async {
    final response = await VenuesRepo().getVenues();

    if (response.isNotEmpty) {
      List<VenuesModel> data = response;
      venuesList.clear();
      for (var e in data) {
        venuesList.add(e);
      }
    }
    notifyListeners();
  }

  Future<void> getFeaturedVenuesList() async {
    final response = await VenuesRepo().getFeaturedVenues();

    if (response.isNotEmpty) {
      List<VenuesModel> data = response;
      venuesFeaturedList.clear();
      for (var e in data) {
        venuesFeaturedList.add(e);
      }
    }
    notifyListeners();
  }

  Future<void> getVenueMenuList(int venueId) async {
    final response = await VenuesRepo().getVenueMenu(2);

    if (response.isNotEmpty) {
      List<VenueMenuModel> data = response;
      venueMenuList.clear();
      for (var e in data) {
        venueMenuList.add(e);
      }
    }
    notifyListeners();
  }

  String getVenueId(String name) {
    try {
      final venue = venuesList.firstWhere(
        (venue) => venue.name == name,
        orElse: () => VenuesModel(),
      );
      return venue.id != null ? venue.id.toString() : '';
    } catch (e) {
      return '';
    }
  }

  VenuesModel selectedVenueData = VenuesModel();

  var isMenuList = false;
  void toggleMenuList() {
    isMenuList = !isMenuList;
    notifyListeners();
  }

  void selectedVenue(int? id) {
    selectedVenueData = VenuesModel();
    selectedVenueData = venuesList.firstWhere((venue) => venue.id == id);
    notifyListeners();
  }

  String getMenuName(int id) {
    return venueMenuList.firstWhere((e) => e.id == id).name.toString();
  }

  String getMenuPrice(int id) {
    return venueMenuList.firstWhere((e) => e.id == id).price.toString();
  }
}
