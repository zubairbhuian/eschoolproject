class DiaryListModel {
  DiaryListModel({
    this.success,
    this.info,
    this.dairy,
    this.cls,
    this.section,
    this.session,
  });

  DiaryListModel.fromJson(dynamic json) {
    success = json['success'];
    info = json['info'];
    if (json['dairy'] != null) {
      dairy = [];
      json['dairy'].forEach((v) {
        dairy?.add(Dairy.fromJson(v));
      });
    }
    if (json['class'] != null) {
      cls = [];
      json['class'].forEach((v) {
        cls?.add(Class.fromJson(v));
      });
    }
    if (json['section'] != null) {
      section = [];
      json['section'].forEach((v) {
        section?.add(Section.fromJson(v));
      });
    }
    if (json['session'] != null) {
      session = [];
      json['session'].forEach((v) {
        session?.add(Session.fromJson(v));
      });
    }
  }
  bool? success;
  String? info;
  List<Dairy>? dairy;
  List<Class>? cls;
  List<Section>? section;
  List<Session>? session;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['info'] = info;
    if (dairy != null) {
      map['dairy'] = dairy?.map((v) => v.toJson()).toList();
    }
    if (cls != null) {
      map['class'] = cls?.map((v) => v.toJson()).toList();
    }
    if (section != null) {
      map['section'] = section?.map((v) => v.toJson()).toList();
    }
    if (session != null) {
      map['session'] = session?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Session {
  Session({
    this.id,
    this.start,
    this.end,
    this.createdAt,
    this.updatedAt,
  });

  Session.fromJson(dynamic json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['start'] = start;
    map['end'] = end;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Section {
  Section({
    this.id,
    this.name,
    this.examClassId,
    this.classGroupsId,
  });

  Section.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    examClassId = json['exam_class_id'];
    classGroupsId = json['class_groups_id'];
  }
  int? id;
  String? name;
  String? examClassId;
  dynamic classGroupsId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['exam_class_id'] = examClassId;
    map['class_groups_id'] = classGroupsId;
    return map;
  }
}

class Class {
  Class({
    this.id,
    this.name,
    this.hasGroup,
    this.hasSection,
    this.sessionId,
  });

  Class.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    hasGroup = json['has_group'];
    hasSection = json['has_section'];
    sessionId = json['session_id'];
  }
  int? id;
  String? name;
  String? hasGroup;
  String? hasSection;
  String? sessionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['has_group'] = hasGroup;
    map['has_section'] = hasSection;
    map['session_id'] = sessionId;
    return map;
  }
}

class Dairy {
  Dairy({
    this.id,
    this.teacherName,
    this.sessionId,
    this.sectionId,
    this.groupId,
    this.classId,
    this.homeWork,
    this.subject,
    this.date,
    this.className,
    this.sectionName,
    this.start,
    this.end,
  });

  Dairy.fromJson(dynamic json) {
    id = json['id'];
    teacherName = json['teacher_name'];
    sessionId = json['session_id'];
    sectionId = json['section_id'];
    groupId = json['group_id'];
    classId = json['class_id'];
    homeWork = json['home_work'];
    subject = json['subject'];
    date = json['date'];
    className = json['className'];
    sectionName = json['section_name'];
    start = json['start'];
    end = json['end'];
  }
  String? id;
  String? teacherName;
  String? sessionId;
  String? sectionId;
  String? groupId;
  String? classId;
  String? homeWork;
  String? subject;
  String? date;
  String? className;
  String? sectionName;
  String? start;
  String? end;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['teacher_name'] = teacherName;
    map['session_id'] = sessionId;
    map['section_id'] = sectionId;
    map['group_id'] = groupId;
    map['class_id'] = classId;
    map['home_work'] = homeWork;
    map['subject'] = subject;
    map['date'] = date;
    map['className'] = className;
    map['section_name'] = sectionName;
    map['start'] = start;
    map['end'] = end;
    return map;
  }
}
