class EventsModel {
  int? id;
  String? eventName;
  String? about;
  String? description;
  String? currency;
  String? picture;
  List<Images>? images;
  String? venueName;
  String? venueCity;

  EventsModel(
      {this.id,
      this.eventName,
      this.about,
      this.description,
      this.currency,
      this.picture,
      this.images,
      this.venueName,
      this.venueCity});

  EventsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    about = json['about'];
    description = json['description'];
    currency = json['currency'];
    picture = json['picture'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['venue_name'] = this.venueName;
    data['venue_city'] = this.venueCity;
    return data;
  }
}

class Images {
  int? id;
  String? thumbnailImage;
  String? bgImage;
  String? imageGl;
  String? seatingPlan;

  Images(
      {this.id,
      this.thumbnailImage,
      this.bgImage,
      this.imageGl,
      this.seatingPlan});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailImage = json['thumbnail_image'];
    bgImage = json['bg_image'];
    imageGl = json['image_gl'];
    seatingPlan = json['seating_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnail_image'] = this.thumbnailImage;
    data['bg_image'] = this.bgImage;
    data['image_gl'] = this.imageGl;
    data['seating_plan'] = this.seatingPlan;
    return data;
  }
}
