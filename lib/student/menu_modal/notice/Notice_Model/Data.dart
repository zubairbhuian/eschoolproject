class Data {
  Data({
      required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.isBraking,
    required this.createdAt,
    required this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
    isBraking = json['is_braking'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String?  title;
  String?  date;
  String?  description;
  String?  isBraking;
  String?  createdAt;
  String?  updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['date'] = date;
    map['description'] = description;
    map['is_braking'] = isBraking;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}