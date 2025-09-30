import 'package:flutter/material.dart';
import 'package:mingly/src/application/events/model/event_details_model.dart';
import 'package:mingly/src/application/events/model/event_ticket_model.dart';
import 'package:mingly/src/application/events/model/events_model.dart';
import 'package:mingly/src/application/events/model/ticket_order_model.dart';
import 'package:mingly/src/application/events/repo/events_repo.dart';

class EventsProvider extends ChangeNotifier {
  List<EventsModel> eventsList = [];

  Future<void> getVenuesList() async {
    final response = await EventsRepo().getEvents();

    if (response.isNotEmpty) {
      List<EventsModel> data = response;
      eventsList.clear();
      for (var e in data) {
        eventsList.add(e);
      }
    }
    notifyListeners();
  }

  EventsModel selectEventModel = EventsModel();

  EventDetailsModel eventDetailsModel = EventDetailsModel();

  Future<void> getEventsDetailsData(String id) async {
    final response = await EventsRepo().getEventsDetails(id);
    if (response != null) {
      eventDetailsModel = response;
    }
    notifyListeners();
  }

  String getTotalPrice() {
    double totalPrice = 0.0;

    selectedTickets.forEach((e) {
      totalPrice +=
          double.parse(getTicketPrice(int.parse(e.ticketId.toString()))) *
          double.parse(e.quantity.toString());
    });

    return totalPrice.toString();
  }

  void selectEventModelFunction(EventsModel model) {
    selectEventModel = EventsModel();
    selectEventModel = model;
    notifyListeners();
  }

  List<EventsTicketModel> eventTicketList = [];

  Future<bool> getEventTicketList(String id) async {
    final response = await EventsRepo().getEventTicket(id);
    if (response.isNotEmpty) {
      List<EventsTicketModel> data = response;
      eventTicketList.clear();
      for (var e in data) {
        eventTicketList.add(e);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  String getTicketName(int id) {
    final e = eventTicketList.firstWhere((e) => e.id == id);
    return e.title.toString();
  }

  String getTicketPrice(int id) {
    final e = eventTicketList.firstWhere((e) => e.id == id);
    return e.price.toString();
  }

  int ticketCount = 1;
  final int maxTickets = 5;

  double totalPrice = 0.0;
  double ticketTotalPrice = 0.0;

  clearData() {
    ticketCount = 1;
    ticketTotalPrice = 0.0;
    notifyListeners();
  }

  incrementTicket(double ticketPrice) {
    if (ticketCount < maxTickets) {
      ticketCount++;
      ticketTotalPrice =
          double.parse(ticketCount.toString()) *
          double.parse(ticketPrice.toString());
    }

    notifyListeners();
  }

  decrementTicket(double ticketPrice) {
    if (ticketCount > 1) {
      ticketCount--;
      ticketTotalPrice =
          double.parse(ticketCount.toString()) *
          double.parse(ticketPrice.toString());
    }

    notifyListeners();
  }

  start(double ticketPrice) {
    ticketTotalPrice =
        double.parse(ticketCount.toString()) *
        double.parse(ticketPrice.toString());
    // totalPrice = ticketTotalPrice;
    notifyListeners();
  }

  final List<TicketOrderItem> selectedTickets = [];

  void addOrUpdateTicket(String ticketId, int quantity) {
    final index = selectedTickets.indexWhere((e) => e.ticketId == ticketId);
    if (index >= 0) {
      selectedTickets[index] = TicketOrderItem(
        ticketId: ticketId,
        quantity: quantity,
      );
    } else {
      selectedTickets.add(
        TicketOrderItem(ticketId: ticketId, quantity: quantity),
      );
    }
    totalPrice += ticketTotalPrice;
    notifyListeners();
  }

  void clearTickets() {
    selectedTickets.clear();
    notifyListeners();
  }

  TicketOrderRequest buildOrderRequest({String? promoCode}) {
    return TicketOrderRequest(
      items: List.from(selectedTickets),
      promoCode: promoCode,
    );
  }

  String? promoCode;

  void getPromoCode(String value) {
    promoCode = "";
    promoCode = value;
    notifyListeners();
  }

  //buy ticket

  Future<Map<String, dynamic>> buyTicketEvent(
    Map<String, dynamic> data,
    id,
  ) async {
    final response = await EventsRepo().buyEventTicket(data, id);
    return response;
  }
}
