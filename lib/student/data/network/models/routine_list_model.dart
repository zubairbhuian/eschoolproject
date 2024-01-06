class RoutineListModel {
  RoutineListModel({
    this.success,
    this.days,
    this.routines,
  });

  RoutineListModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days?.add(Days.fromJson(v));
      });
    }
    if (json['routines'] != null) {
      routines = [];
      json['routines'].forEach((v) {
        routines?.add(Routines.fromJson(v));
      });
    }
  }
  bool? success;
  List<Days>? days;
  List<Routines>? routines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    if (routines != null) {
      map['routines'] = routines?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Routines {
  Routines({
    this.id,
    this.dayName,
    this.className,
    this.section,
    this.subject,
    this.dayId,
    this.routineId,
    this.period,
    this.startTime,
    this.endTime,
  });

  Routines.fromJson(dynamic json) {
    id = json['id'];
    dayName = json['day_name'];
    className = json['class_name'];
    section = json['section'];
    subject = json['subject'];
    dayId = json['day_id'];
    routineId = json['routine_id'];
    period = json['period'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  String? id;
  String? dayName;
  String? className;
  String? section;
  String? subject;
  String? dayId;
  String? routineId;
  String? period;
  String? startTime;
  String? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['day_name'] = dayName;
    map['class_name'] = className;
    map['section'] = section;
    map['subject'] = subject;
    map['day_id'] = dayId;
    map['routine_id'] = routineId;
    map['period'] = period;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }
}

class Days {
  Days({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Days.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
