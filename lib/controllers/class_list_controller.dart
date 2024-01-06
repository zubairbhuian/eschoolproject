import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/network/models/class_list_model.dart';
import 'package:get/get.dart';

class ClassListController extends GetxController {
  Server server = Server();
  bool loader = false;

  List<Class> classList = <Class>[];
  List<Section> sectionList = <Section>[];
  List<Subject> subjectList = <Subject>[];

  getClassListInfo() async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    server.getRequest(endPoint: Endpoints.classList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var classListData = ClassListModel.fromJson(jsonResponse);

        classList = <Class>[];
        classList.addAll(classListData.cls!);

        sectionList = <Section>[];
        sectionList.addAll(classListData.section!);

        subjectList = <Subject>[];
        subjectList.addAll(classListData.subject!);

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
