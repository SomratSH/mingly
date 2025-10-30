class MenuBookingModel {
  int? id;
  int? quantity;

  MenuBookingModel(this.id, this.quantity);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
