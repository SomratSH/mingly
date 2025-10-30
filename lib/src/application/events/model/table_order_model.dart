import 'package:mingly/src/application/events/model/menu_booking_model.dart';

class TableBooking {
  int? seatId;
  int? tableId;
  String? selectedTime;
  String? price;
  String? paymentType;
  List<MenuBookingModel>? menu;

  TableBooking({
    this.seatId,
    this.selectedTime,
    this.price,
    this.paymentType,
    this.menu,
    this.tableId,
  });

  TableBooking.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id'];
    selectedTime = json['selected_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['table_id'] = tableId;
    data['selected_time'] = selectedTime;
    data["payment_type"] = paymentType;
    data['menu_items'] = menu!.map((e) => e.toJson()).toList();

    return data;
  }
}
