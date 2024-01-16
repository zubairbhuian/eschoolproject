import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/models/feedback_list_model.dart';
import 'package:get/get.dart';

class FeedbackListController extends GetxController {
  Server server = Server();
  bool loader = false;
  List<Feedbacks> feedbackList = <Feedbacks>[];

  getDiaryList(examClassId, sectionId) async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    server
        .getRequest(
            endPoint:
                'feedback-list?exam_class_id=$examClassId&section_id=$sectionId')
        .then((response) {
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var feedbackListData = FeedbackListModel.fromJson(jsonResponse);

        feedbackList = <Feedbacks>[];
        feedbackList.addAll(feedbackListData.feedbacks!);

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
