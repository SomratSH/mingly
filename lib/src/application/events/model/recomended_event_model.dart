class RecomendedEventModel {
  List<Recommendations>? recommended;

  RecomendedEventModel({this.recommended});

  RecomendedEventModel.fromJson(Map<String, dynamic> json) {
    if (json['recommended_events'] != null) {
      recommended = <Recommendations>[];
      json['recommended_events'].forEach((v) {
        recommended!.add(new Recommendations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recommended != null) {
      data['recommended_events'] = this.recommended!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class Recommendations {
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

  Recommendations({
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

  Recommendations.fromJson(Map<String, dynamic> json) {
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
