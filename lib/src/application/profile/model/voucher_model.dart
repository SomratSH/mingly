class VoucherModel {
  String? code;
  double? discountPercent;
  String? description;
  String? expiryDate;
  bool? used;

  VoucherModel({
    this.code,
    this.discountPercent,
    this.description,
    this.expiryDate,
    this.used,
  });

  VoucherModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discountPercent = json['discount_percent'];
    description = json['description'];
    expiryDate = json['expiry_date'];
    used = json['used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['discount_percent'] = this.discountPercent;
    data['description'] = this.description;
    data['expiry_date'] = this.expiryDate;
    data['used'] = this.used;
    return data;
  }
}
