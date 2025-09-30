class VenuesModel {
  int? id;
  String? name;
  String? description;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? latitude;
  String? longitude;
  int? capacity;
  Null? seatingLayout;
  Null? facilities;
  Null? contactPerson;
  String? contactEmail;
  String? contactPhone;
  String? websiteUrl;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  List<OpeningHours>? openingHours;

  VenuesModel(
      {this.id,
      this.name,
      this.description,
      this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.capacity,
      this.seatingLayout,
      this.facilities,
      this.contactPerson,
      this.contactEmail,
      this.contactPhone,
      this.websiteUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.openingHours});

  VenuesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    capacity = json['capacity'];
    seatingLayout = json['seating_layout'];
    facilities = json['facilities'];
    contactPerson = json['contact_person'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    websiteUrl = json['website_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    if (json['opening_hours'] != null) {
      openingHours = <OpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(new OpeningHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['capacity'] = this.capacity;
    data['seating_layout'] = this.seatingLayout;
    data['facilities'] = this.facilities;
    data['contact_person'] = this.contactPerson;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['website_url'] = this.websiteUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    if (this.openingHours != null) {
      data['opening_hours'] =
          this.openingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OpeningHours {
  String? day;
  String? open;
  String? close;

  OpeningHours({this.day, this.open, this.close});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
