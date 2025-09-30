class EventDetailsModel {
  String? eventName;
  String? description;
  String? city;
  String? firstSessionDate;
  String? sessionStartTime;
  String? sessionEndTime;

  EventDetailsModel({
    this.eventName,
    this.description,
    this.city,
    this.firstSessionDate,
    this.sessionStartTime,
    this.sessionEndTime,
  });

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    description = json['description'];
    city = json['city'];
    firstSessionDate = json['first_session_date'];
    sessionStartTime = json['session_start_time'];
    sessionEndTime = json['session_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_name'] = this.eventName;
    data['description'] = this.description;
    data['city'] = this.city;
    data['first_session_date'] = this.firstSessionDate;
    data['session_start_time'] = this.sessionStartTime;
    data['session_end_time'] = this.sessionEndTime;
    return data;
  }
}
