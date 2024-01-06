import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/service/user_service.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvideFeedbackController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = false;

  TextEditingController descriptionController = TextEditingController();

  provideFeedback(BuildContext context, String? name, String? clsId,
      String? sectionId, String? description) async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    Map body = {
      'name': name,
      'exam_class_id': clsId,
      'section_id': sectionId,
      'description': description,
    };
    String jsonBody = json.encode(body);

    server
        .postRequest(endPoint: Endpoints.provideFeedback, body: jsonBody)
        .then((response) {
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        clsId = null;
        sectionId = null;
        descriptionController.clear();

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
