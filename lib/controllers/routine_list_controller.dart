import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/network/models/routine_list_model.dart';
import 'package:get/get.dart';

class RoutineListController extends GetxController {
  Server server = Server();
  bool loader = false;
  List<Days> daysList = <Days>[];
  List<Routines> routineList = <Routines>[];

  getRoutineList() async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    server.getRequest(endPoint: Endpoints.routineList).then((response) {
      print(json.decode(response.body));

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var routineData = RoutineListModel.fromJson(jsonResponse);

        daysList = <Days>[];
        daysList.addAll(routineData.days!);

        routineList = <Routines>[];
        routineList.addAll(routineData.routines!);

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
