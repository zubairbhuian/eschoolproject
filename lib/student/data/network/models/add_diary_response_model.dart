class AddDiaryResponseModel {
  AddDiaryResponseModel({
    this.success,
    this.info,
    // this.data,
  });

  AddDiaryResponseModel.fromJson(dynamic json) {
    success = json['success'];
    info = json['info'];
    // if (json['data'] != null) {
    //   data = [];
    //   json['data'].forEach((v) {
    //     data?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  bool? success;
  String? info;
  // List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['info'] = info;
    // if (data != null) {
    //   map['data'] = data?.map((v) => v.toJson()).toList();
    // }
    return map;
  }
}
