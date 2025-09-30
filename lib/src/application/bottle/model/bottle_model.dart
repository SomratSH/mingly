class BottleModel {
  int? id;
  String? brand;
  String? keepingDate;
  String? expiredDate;
  int? quantity;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  BottleModel({
    this.id,
    this.brand,
    this.keepingDate,
    this.expiredDate,
    this.quantity,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  BottleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    keepingDate = json['keeping_date'];
    expiredDate = json['expired_date'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['keeping_date'] = this.keepingDate;
    data['expired_date'] = this.expiredDate;
    data['quantity'] = this.quantity;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
