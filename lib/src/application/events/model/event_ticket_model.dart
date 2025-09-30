class EventsTicketModel {
  int? id;
  String? title;
  String? price;
  int? totalTicketQty;
  int? isHasBookingLimit;
  int? ticketLimit;
  int? isHasAllowKids;
  String? description;
  int? isOffer;
  Null? startOfferDateTime;
  Null? endOfferDateTime;
  String? offerValue;
  int? availableSales;
  int? isSoldOut;
  String? createdAt;
  String? updatedAt;
  Null? ticketType;
  int? event;
  int? commission;
  int? tax;
  int? promocode;

  EventsTicketModel(
      {this.id,
      this.title,
      this.price,
      this.totalTicketQty,
      this.isHasBookingLimit,
      this.ticketLimit,
      this.isHasAllowKids,
      this.description,
      this.isOffer,
      this.startOfferDateTime,
      this.endOfferDateTime,
      this.offerValue,
      this.availableSales,
      this.isSoldOut,
      this.createdAt,
      this.updatedAt,
      this.ticketType,
      this.event,
      this.commission,
      this.tax,
      this.promocode});

  EventsTicketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    totalTicketQty = json['total_ticket_qty'];
    isHasBookingLimit = json['is_has_booking_limit'];
    ticketLimit = json['ticket_limit'];
    isHasAllowKids = json['is_has_allow_kids'];
    description = json['description'];
    isOffer = json['is_offer'];
    startOfferDateTime = json['start_offer_date_time'];
    endOfferDateTime = json['end_offer_date_time'];
    offerValue = json['offer_value'];
    availableSales = json['available_sales'];
    isSoldOut = json['is_sold_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ticketType = json['ticket_type'];
    event = json['event'];
    commission = json['commission'];
    tax = json['tax'];
    promocode = json['promocode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['total_ticket_qty'] = this.totalTicketQty;
    data['is_has_booking_limit'] = this.isHasBookingLimit;
    data['ticket_limit'] = this.ticketLimit;
    data['is_has_allow_kids'] = this.isHasAllowKids;
    data['description'] = this.description;
    data['is_offer'] = this.isOffer;
    data['start_offer_date_time'] = this.startOfferDateTime;
    data['end_offer_date_time'] = this.endOfferDateTime;
    data['offer_value'] = this.offerValue;
    data['available_sales'] = this.availableSales;
    data['is_sold_out'] = this.isSoldOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ticket_type'] = this.ticketType;
    data['event'] = this.event;
    data['commission'] = this.commission;
    data['tax'] = this.tax;
    data['promocode'] = this.promocode;
    return data;
  }
}
