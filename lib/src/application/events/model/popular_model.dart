class PopularEventModel {
  List<TopPopularEvents>? topPopularEvents;

  PopularEventModel({this.topPopularEvents});

  PopularEventModel.fromJson(Map<String, dynamic> json) {
    if (json['top_popular_events'] != null) {
      topPopularEvents = <TopPopularEvents>[];
      json['top_popular_events'].forEach((v) {
        topPopularEvents!.add(new TopPopularEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topPopularEvents != null) {
      data['top_popular_events'] = this.topPopularEvents!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class TopPopularEvents {
  int? id;
  String? eventName;
  String? about;
  String? description;
  String? currency;
  String? picture;
  int? totalBookings;
  String? createdAt;
  String? updatedAt;
  String? venueName;
  String? venueCity;

  TopPopularEvents({
    this.id,
    this.eventName,
    this.about,
    this.description,
    this.currency,
    this.picture,
    this.totalBookings,
    this.createdAt,
    this.updatedAt,
    this.venueName,
    this.venueCity,
  });

  TopPopularEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    about = json['about'];
    description = json['description'];
    currency = json['currency'];
    picture = json['picture'];
    totalBookings = json['total_bookings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    venueName = json['venue_name'];
    venueCity = json['venue_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['about'] = this.about;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['picture'] = this.picture;
    data['total_bookings'] = this.totalBookings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['venue_name'] = this.venueName;
    data['venue_city'] = this.venueCity;
    return data;
  }
}
