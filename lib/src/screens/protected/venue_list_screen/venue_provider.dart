import 'package:flutter/material.dart';
import 'package:mingly/src/application/venues/model/venues_model.dart';
import 'package:mingly/src/application/venues/repo/venues_repo.dart';

class VenueProvider extends ChangeNotifier {
  List<VenuesModel> venuesList = [];

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

  VenuesModel selectedVenueData = VenuesModel();
  void selectedVenue(int? id) {
    selectedVenueData = venuesList.firstWhere((venue) => venue.id == id);
    notifyListeners();
  }
}
