import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/feedback_list_controller.dart';
import 'package:eschoolproject/student/menu_modal/teachers_feedback/teachers_feedback_details.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../Widget/app_default_bar.dart';

class TeachersFeedback extends StatefulWidget {
  const TeachersFeedback({Key? key}) : super(key: key);

  @override
  State<TeachersFeedback> createState() => _TeachersFeedbackState();
}

class _TeachersFeedbackState extends State<TeachersFeedback> {
  FeedbackListController feedbackListController = FeedbackListController();
  final _myBox = Hive.box('eSchoolBox');

  @override
  void didChangeDependencies() {
    feedbackListController = Get.put(FeedbackListController());
    feedbackListController.getDiaryList(
        _myBox.get('studentClsId'), _myBox.get('studentSectionId'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackListController>(
      init: FeedbackListController(),
      builder: (feedbackList) => Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              AppDefaultBar(title: "FeedBack"),
              feedbackList.loader
                  ? const Expanded(
                      child: Center(
                        child: AppIndecator(),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: feedbackList.feedbackList.length,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => TeachersFeedbackDetails(
                                    teacherName: feedbackList
                                        .feedbackList[index].name
                                        .toString(),
                                    teacherFeedback: feedbackList
                                        .feedbackList[index].description
                                        .toString(),
                                  ),
                                );
                              },
                              child: Card(
                                color: Constants.whiteGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            feedbackList
                                                .feedbackList[index].description
                                                .toString(),
                                            style: const TextStyle(
                                              color: Constants.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            feedbackList
                                                .feedbackList[index].name
                                                .toString(),
                                            // snapshot.data![index].date!.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                height: 1),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Constants.primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
