class FeedbackListModel {
  FeedbackListModel({
    this.success,
    this.info,
    this.feedbacks,
  });

  FeedbackListModel.fromJson(dynamic json) {
    success = json['success'];
    info = json['info'];
    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks?.add(Feedbacks.fromJson(v));
      });
    }
  }
  bool? success;
  String? info;
  List<Feedbacks>? feedbacks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['info'] = info;
    if (feedbacks != null) {
      map['feedbacks'] = feedbacks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Feedbacks {
  Feedbacks({
    this.id,
    this.name,
    this.description,
  });

  Feedbacks.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
  String? id;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
