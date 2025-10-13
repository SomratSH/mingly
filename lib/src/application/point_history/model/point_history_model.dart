class PointHistory {
  String? user;
  int? totalPoints;
  List<History>? history;

  PointHistory({this.user, this.totalPoints, this.history});

  PointHistory.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    totalPoints = json['total_points'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['total_points'] = this.totalPoints;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  int? id;
  int? points;
  String? transactionType;
  String? description;
  String? createdAt;

  History(
      {this.id,
      this.points,
      this.transactionType,
      this.description,
      this.createdAt});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    transactionType = json['transaction_type'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['transaction_type'] = this.transactionType;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
