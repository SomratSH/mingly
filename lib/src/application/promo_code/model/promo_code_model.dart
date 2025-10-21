class PromoCodeModel {
  int? id;
  String? code;
  String? discountType;
  String? discountValue;
  String? startDate;
  String? endDate;
  String? status;

  PromoCodeModel(
      {this.id,
      this.code,
      this.discountType,
      this.discountValue,
      this.startDate,
      this.endDate,
      this.status});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    return data;
  }
}
