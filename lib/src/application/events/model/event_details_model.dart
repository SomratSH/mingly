class EventDetailsModel {
  String? eventName;
  String? description;
  String? city;
  String? firstSessionDate;
  String? sessionStartTime;
  String? sessionEndTime;
  String? requiredMembershipLevel;
  List<Images>? images;

  EventDetailsModel({
    this.eventName,
    this.description,
    this.city,
    this.firstSessionDate,
    this.sessionStartTime,
    this.sessionEndTime,
    this.requiredMembershipLevel,
    this.images,
  });

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    description = json['description'];
    city = json['city'];
    firstSessionDate = json['first_session_date'];
    sessionStartTime = json['session_start_time'];
    sessionEndTime = json['session_end_time'];
    requiredMembershipLevel = json['required_membership_level'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_name'] = this.eventName;
    data['description'] = this.description;
    data['city'] = this.city;
    data['first_session_date'] = this.firstSessionDate;
    data['session_start_time'] = this.sessionStartTime;
    data['session_end_time'] = this.sessionEndTime;
    data['required_membership_level'] = this.requiredMembershipLevel;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? thumbnailImage;
  String? bgImage;
  String? imageGl;
  String? seatingPlan;

  Images({
    this.id,
    this.thumbnailImage,
    this.bgImage,
    this.imageGl,
    this.seatingPlan,
  });

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
