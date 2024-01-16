import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/network/models/add_diary_response_model.dart';
import 'package:eschoolproject/student/data/service/user_service.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitDiaryController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = false;
  dynamic successMsg;
  TextEditingController subjectController = TextEditingController();
  TextEditingController homeWorkController = TextEditingController();

  submitDairy(
    BuildContext context,
    String? name,
    String? sessionId,
    String? clsId,
    String? sectionId,
    String? subject,
    String? homeWork,
  ) async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    Map body = {
      'teacher_name': name,
      'session_id': sessionId,
      'class_id': clsId,
      'section_id': sectionId,
      'subject': subject,
      'home_work': homeWork,
    };
    String jsonBody = json.encode(body);

    server
        .postRequest(endPoint: Endpoints.addDiary, body: jsonBody)
        .then((response) {
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var diaryData = AddDiaryResponseModel.fromJson(jsonResponse);
        successMsg = diaryData.info;

        subjectController.clear();
        homeWorkController.clear();

        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(
            message: 'Submission Successful!',
            backgroundColor: Constants.successMsgColor);
      } else {
        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
