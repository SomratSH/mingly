class TableBooking {
  int? seatId;
  String? selectedTime;

  TableBooking({this.seatId, this.selectedTime});

  TableBooking.fromJson(Map<String, dynamic> json) {
    seatId = json['seat_id'];
    selectedTime = json['selected_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['seat_id'] = seatId;
    data['selected_time'] = selectedTime;
    return data;
  }
}
