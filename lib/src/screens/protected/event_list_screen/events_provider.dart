import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mingly/src/application/events/model/event_details_model.dart';
import 'package:mingly/src/application/events/model/event_ticket_model.dart';
import 'package:mingly/src/application/events/model/events_model.dart';
import 'package:mingly/src/application/events/model/menu_booking_model.dart';
import 'package:mingly/src/application/events/model/popular_model.dart';
import 'package:mingly/src/application/events/model/recomended_event_model.dart';
import 'package:mingly/src/application/events/model/table_order_model.dart';
import 'package:mingly/src/application/events/model/table_ticket_model.dart';
import 'package:mingly/src/application/events/model/ticket_order_model.dart';
import 'package:mingly/src/application/events/repo/events_repo.dart';

class EventsProvider extends ChangeNotifier {
  List<EventsModel> eventsList = [];
  int currentIndex = 0;
  List<String> eventDetailsImageList = [];

  previousImage() {
    if (currentIndex > 0) {
      currentIndex--;
    }
    notifyListeners();
  }

  nextImage() {
    if (currentIndex < eventDetailsModel.images!.length - 1) {
      currentIndex++;
    }
    notifyListeners();
  }

  Future<void> getEventList() async {
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

  Future<void> getEventListSearch(String date, String search) async {
    final response = await EventsRepo().getEventsSearch(search, date);

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
      eventDetailsImageList.clear();
      eventDetailsImageList =
          eventDetailsModel.images == null ||
              eventDetailsModel.images!.isEmpty ||
              eventDetailsModel.images!.first.imageGl == null ||
              eventDetailsModel.images!.first.imageGl!.isEmpty
          ? []
          : List<String>.from(
              jsonDecode(eventDetailsModel.images!.first.imageGl.toString()),
            );
      eventDetailsImageList.forEach((e) {
        print(e);
      });
    }
    notifyListeners();
  }

  double promoDiscount = 0.0;
  String getTotalPrice() {
    double totalPrice = 0.0;

    selectedTickets.forEach((e) {
      totalPrice +=
          double.parse(getTicketPrice(int.parse(e.ticketId.toString()))) *
          double.parse(e.quantity.toString());
    });

    return (totalPrice).toString();
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

  //event table ticket list
  TableTicketModel tableTicketModel = TableTicketModel();
  Future<bool> getTableTicketList(String date, String time) async {

    final response = await EventsRepo().getTableTicket(
      selectEventModel.id.toString(),
      date,
      time,
    );
    if (response.isNotEmpty && response['tables'] != null) {
      tableTicketModel = TableTicketModel.fromJson(response);
      notifyListeners();
      return true;
    }
    return false;
  }

  List<String> getChair(int?id) {
    for (var e in tableTicketModel.tables!) {
      if (e.id == id) {
        if (e.chairs == null || e.chairs!.isEmpty) {
          return [];
        }
        return e.chairs!;
      }
    }
    return [];
  }

  Tables selecteTable = Tables();
  void selectedTable(Tables data) {
    selecteTable = Tables();
    selecteTable = data;
    notifyListeners();
  }

  String? selectedCategory;
  final List<String> categories = [
    'Coffee',
    'Tea',
    'Juice',
    'Soft Drinks',
    'Smoothies',
  ];

  void updateCatagory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  TableBooking tableBooking = TableBooking();

  void selecteTableBooking(int tableid, String selectedTime, int seatId) {
    tableBooking = TableBooking();
    tableBooking = TableBooking(
      seatId: seatId,
      tableId: tableid,
      selectedTime: selectedTime,
      paymentType: _isDownPayment ? "full" : "down",
      menu: menuList,
    );
    notifyListeners();
  }

  List<MenuBookingModel> menuList = [];

  addMenu(int id, int qty) {
    menuList.add(MenuBookingModel(id, qty));
    notifyListeners();
  }

  removeMenu(int index) {
    if (menuList.isNotEmpty) {
      menuList.removeAt(index);
    }
    notifyListeners();
  }



  Future<Map<String, dynamic>> buyTableTicketEvent(
    Map<String, dynamic> data,
    id,
  ) async {
    print(data);
    final response = await EventsRepo().buyTableEventTicket(data, id);
    return response;
  }

  PopularEventModel popularEventModel = PopularEventModel();
  RecomendedEventModel recomendedEventModel = RecomendedEventModel();
  Future<void> getPopularEventList() async {
    final response = await EventsRepo().getPopularEvent();
    if (response.isNotEmpty) {
      popularEventModel = PopularEventModel.fromJson(response);
      notifyListeners();
    }
  }

  Future<void> getRecomendedEventList() async {
    final response = await EventsRepo().getRecomendedEvent();
    if (response.isNotEmpty) {
      recomendedEventModel = RecomendedEventModel.fromJson(response);
      notifyListeners();
    }
  }

  List<String> listedTimeSlot = [
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    '11:00',
    '11:15',
    '11:30',
    '11:45',
    '12:00',
    '12:15',
    '12:30',
    '12:45',
    '13:00',
  ];
  int indexOfSelectedTimeSlot = -1;
  void selectTimeSlot(int index) {
    indexOfSelectedTimeSlot = index;
    notifyListeners();
  }

  List<EventsModel> eventsListVenueWise = [];
  Future<void> getEvetListVuneWise(int id) async {
    final response = await EventsRepo().getEventsVenuseWise(id);
    eventsListVenueWise.clear();
    if (response.isNotEmpty) {
      List<EventsModel> data = response;

      for (var e in data) {
        eventsListVenueWise.add(e);
      }
    }
    notifyListeners();
  }

  void calculateTotalAmountWithPromo(String promo) {
    // Logic to calculate total amount with promo code
    promoDiscount = double.tryParse(promo) ?? 0.0;
    notifyListeners();
  }

  double promoValue = 0.0;

  void addPromoValue() {
    promoValue = promoDiscount;
    notifyListeners();
  }

  bool _isDownPayment = false;

  bool get isDownPayment => _isDownPayment;

  void toggleDownPayment(bool value) {
    _isDownPayment = value;
    notifyListeners();
  }
}
