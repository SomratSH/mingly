class PakageModel {
  String? name;
  double? price;
  String? description;
  String? benefits;

  PakageModel({this.name, this.price, this.description, this.benefits});

  PakageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    benefits = json['benefits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['benefits'] = this.benefits;
    return data;
  }
}
