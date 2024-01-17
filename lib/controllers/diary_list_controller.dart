import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/network/models/diary_list_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiaryListController extends GetxController {
  Server server = Server();
  bool loader = false;
  List<Dairy> diaryList = <Dairy>[];
  List<Class> classList = <Class>[];
  List<Section> sectionList = <Section>[];
  List<Session> sessionList = <Session>[];
  List myDiaryList = [];

  String onDateFormet(String data) {
    return DateFormat('DD-MM-yyyy').format(DateTime.parse(data));
  }

  onMyDiaryList(String name) {
    try {
      myDiaryList  = diaryList.where((diary) =>
          diary.teacherName == name &&
          onDateFormet("${diary.date!}") == onDateFormet("2024-01-14")).toList();
    } catch (e) {
      print(e);
    }
  }

  getDiaryList() async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    server.getRequest(endPoint: Endpoints.diaryList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var diaryListData = DiaryListModel.fromJson(jsonResponse);

        diaryList = <Dairy>[];
        diaryList.addAll(diaryListData.dairy!);

        classList = <Class>[];
        classList.addAll(diaryListData.cls!);

        sectionList = <Section>[];
        sectionList.addAll(diaryListData.section!);

        sessionList = <Session>[];
        sessionList.addAll(diaryListData.session!);

        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Something went wrong');
      }
    });
  }
}
