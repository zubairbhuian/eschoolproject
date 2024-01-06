class ClassListModel {
  ClassListModel({
    this.success,
    this.info,
    this.cls,
    this.section,
    this.subject,
  });

  ClassListModel.fromJson(dynamic json) {
    success = json['success'];
    info = json['info'];
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
    if (json['subject'] != null) {
      subject = [];
      json['subject'].forEach((v) {
        subject?.add(Subject.fromJson(v));
      });
    }
  }
  bool? success;
  String? info;
  List<Class>? cls;
  List<Section>? section;
  List<Subject>? subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['info'] = info;
    if (cls != null) {
      map['class'] = cls?.map((v) => v.toJson()).toList();
    }
    if (section != null) {
      map['section'] = section?.map((v) => v.toJson()).toList();
    }
    if (subject != null) {
      map['subject'] = subject?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Subject {
  Subject({
    this.id,
    this.name,
    this.subjectCode,
    this.isOptional,
    this.examClassId,
    this.classGroupId,
    this.sectionId,
    this.combinedSubject,
    this.combinedName,
    this.fullMark,
    this.caPass,
    this.creativePass,
    this.mcqPass,
    this.practicalPass,
    this.createdAt,
    this.updatedAt,
  });

  Subject.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    subjectCode = json['subject_code'];
    isOptional = json['is_optional'];
    examClassId = json['exam_class_id'];
    classGroupId = json['class_group_id'];
    sectionId = json['section_id'];
    combinedSubject = json['combined_subject'];
    combinedName = json['combined_name'];
    fullMark = json['full_mark'];
    caPass = json['ca_pass'];
    creativePass = json['creative_pass'];
    mcqPass = json['mcq_pass'];
    practicalPass = json['practical_pass'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? subjectCode;
  String? isOptional;
  String? examClassId;
  dynamic classGroupId;
  String? sectionId;
  String? combinedSubject;
  String? combinedName;
  String? fullMark;
  String? caPass;
  String? creativePass;
  String? mcqPass;
  String? practicalPass;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['subject_code'] = subjectCode;
    map['is_optional'] = isOptional;
    map['exam_class_id'] = examClassId;
    map['class_group_id'] = classGroupId;
    map['section_id'] = sectionId;
    map['combined_subject'] = combinedSubject;
    map['combined_name'] = combinedName;
    map['full_mark'] = fullMark;
    map['ca_pass'] = caPass;
    map['creative_pass'] = creativePass;
    map['mcq_pass'] = mcqPass;
    map['practical_pass'] = practicalPass;
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
