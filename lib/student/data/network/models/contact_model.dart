class ContactModel {
  ContactModel({
    this.success,
    this.info,
    this.data,
  });

  ContactModel.fromJson(dynamic json) {
    success = json['success'];
    info = json['info'];
    data = json['data'] != null ? ContactData.fromJson(json['data']) : null;
  }
  bool? success;
  String? info;
  ContactData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['info'] = info;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class ContactData {
  ContactData({
    this.id,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.title,
    this.innerPageWessiteName,
    this.logo1,
    this.logo2,
    this.createdAt,
    this.updatedAt,
  });

  ContactData.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    title = json['title'];
    innerPageWessiteName = json['inner_page_wessite_name'];
    logo1 = json['logo1'];
    logo2 = json['logo2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? address;
  String? phone;
  String? email;
  String? website;
  String? title;
  String? innerPageWessiteName;
  String? logo1;
  String? logo2;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address'] = address;
    map['phone'] = phone;
    map['email'] = email;
    map['website'] = website;
    map['title'] = title;
    map['inner_page_wessite_name'] = innerPageWessiteName;
    map['logo1'] = logo1;
    map['logo2'] = logo2;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
