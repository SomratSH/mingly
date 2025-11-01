class AdsImage {
  int? id;
  String? title;
  String? imageUrl;
  String? altText;
  String? caption;
  int? createdBy;
  String? createdByName;
  String? createdAt;
  String? updatedAt;

  AdsImage(
      {this.id,
      this.title,
      this.imageUrl,
      this.altText,
      this.caption,
      this.createdBy,
      this.createdByName,
      this.createdAt,
      this.updatedAt});

  AdsImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
    altText = json['alt_text'];
    caption = json['caption'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['alt_text'] = this.altText;
    data['caption'] = this.caption;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
