class FavouriteModel {
  int? id;
  int? event;
  String? eventName;
  String? eventPicture;
  String? address;
  String? city;
  String? state;
  String? country;
  String? addedAt;

  FavouriteModel({
    this.id,
    this.event,
    this.eventName,
    this.eventPicture,
    this.address,
    this.city,
    this.state,
    this.country,
    this.addedAt,
  });

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event = json['event'];
    eventName = json['event_name'];
    eventPicture = json['event_picture'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    addedAt = json['added_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event'] = this.event;
    data['event_name'] = this.eventName;
    data['event_picture'] = this.eventPicture;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['added_at'] = this.addedAt;
    return data;
  }
}
