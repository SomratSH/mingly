import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mingly/src/api_service/api_service.dart';
import 'package:mingly/src/application/events/model/event_details_model.dart';
import 'package:mingly/src/application/events/model/event_ticket_model.dart';
import 'package:mingly/src/application/events/model/events_model.dart';
import 'package:mingly/src/application/events/model/table_ticket_model.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsRepo {
  Future<List<EventsModel>> getEvents() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.eventsUrl,
      authToken: preferences.getString("authToken"),
    );
    return response.map((e) => EventsModel.fromJson(e)).toList();
  }

  Future<EventDetailsModel> getEventsDetails(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      "${AppUrls.eventDetails}$id/detail/",
      authToken: preferences.getString("authToken"),
    );
    return EventDetailsModel.fromJson(response);
  }

  Future<List<EventsTicketModel>> getEventTicket(String id) async {
    final response = await ApiService().getList("${AppUrls.ticketList}$id/");
    return response.map((e) => EventsTicketModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> buyEventTicket(
    Map<String, dynamic> data,
    String id,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postData(
      "${AppUrls.buyTicket}${id}/",
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> getTableTicket(
    String eventId,
    String date,
    String selectedTime,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      "${AppUrls.getTableTicket}$eventId/?date=$date&selected_time=$selectedTime",
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> buyTableEventTicket(
    Map<String, dynamic> data,
    String id,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postData(
      "${AppUrls.tableBook}${id}/",
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> getPopularEvent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getData(
      AppUrls.getPopularEvent,
      authToken: preferences.getString("authToken"),
    );
    return reseponse;
  }
}
