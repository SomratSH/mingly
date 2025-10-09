class EventsModel {
  int? id;
  String? eventName;
  String? about;
  String? description;
  String? currency;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? venueName;
  String? venueCity;

  EventsModel({
    this.id,
    this.eventName,
    this.about,
    this.description,
    this.currency,
    this.createdAt,
    this.image,
    this.updatedAt,
    this.venueName,
    this.venueCity,
  });

  EventsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    about = json['about'];
    description = json['description'];
    currency = json['currency'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    venueName = json['venue_name'];
    venueCity = json['venue_city'];
    image = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['about'] = this.about;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['venue_name'] = this.venueName;
    data['venue_city'] = this.venueCity;
    return data;
  }
}
