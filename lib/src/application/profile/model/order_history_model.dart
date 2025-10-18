class OrderHistoryModel {
  List<Orders>? orders;

  OrderHistoryModel({this.orders});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? orderNumber;
  int? eventId;
  String? eventName;
  String? status;
  String? paymentStatus;
  double? subtotal;
  double? totalAmount;
  String? currency;
  String? createdAt;
  List<Items>? items;

  Orders({
    this.orderNumber,
    this.eventId,
    this.eventName,
    this.status,
    this.paymentStatus,
    this.subtotal,
    this.totalAmount,
    this.currency,
    this.createdAt,
    this.items,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    eventId = json['event_id'];
    eventName = json['event_name'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    subtotal = json['subtotal'];
    totalAmount = json['total_amount'];
    currency = json['currency'];
    createdAt = json['created_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['subtotal'] = this.subtotal;
    data['total_amount'] = this.totalAmount;
    data['currency'] = this.currency;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? ticketId;
  String? seatNumber;
  double? unitPrice;
  double? subtotal;
  double? totalAmount;
  String? status;

  Items({
    this.ticketId,
    this.seatNumber,
    this.unitPrice,
    this.subtotal,
    this.totalAmount,
    this.status,
  });

  Items.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    seatNumber = json['seat_number'];
    unitPrice = json['unit_price'];
    subtotal = json['subtotal'];
    totalAmount = json['total_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['seat_number'] = this.seatNumber;
    data['unit_price'] = this.unitPrice;
    data['subtotal'] = this.subtotal;
    data['total_amount'] = this.totalAmount;
    data['status'] = this.status;
    return data;
  }
}
