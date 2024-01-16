import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../data/network/apis/api_client.dart';
import '../../data/network/constants/endpoints.dart';
import '../../data/sharepref/shared_preference_helper.dart';
import 'exam_details_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with TickerProviderStateMixin {
  double screenWidth = 0;
  double screenHeight = 0;
  late TabController _tabController;
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  bool isLoading = false;
  dynamic allExamList;
  List<dynamic> upcomingExamList = [];
  List<dynamic> completedExamList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    getAllExam();
  }

  Future<dynamic> getAllExam() async {
    isLoading = true;
    allExamList = await ApiClient().getData(
        "${Endpoints.examList}?id_number=${await sharedPreferenceHelper.studentId}");

    if (allExamList == false) {
      isLoading = true;
    } else {
      allExamList["data"].forEach((singleExam) {
        print('data => ${singleExam['publish_date']}');

        if (singleExam['publish_date'].toString() != "null") {
          String dateString = singleExam['publish_date'];
          DateTime now = DateTime.now();
          DateTime date = DateTime.parse(dateString);

          if (date.isBefore(now) && now != date) {
            completedExamList.add(singleExam);
          } else if (date.isAfter(now)) {
            upcomingExamList.add(singleExam);
          } else {
            // print("$date is the same as $now");
          }
        } else {
          //
        }
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            AppDefaultBar(title: "Exams"),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Constants.primaryColor ,
                      borderRadius: BorderRadius.circular(8)),
                  tabs: const [
                    Tab(child: Text("All Exams", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                    Tab(
                        child: Text(
                      "Upcoming",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                    // Tab(
                    //     child: Text(
                    //   "Ongoing",
                    //   style: TextStyle(),
                    // )),
                    Tab(child: Text("Completed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                  ]),
            ),
            Flexible(
                child: TabBarView(children: [
              Center(
                  child: isLoading == false
                      ? allExamListView
                      : const AppIndecator()),
              Center(
                  child: isLoading == false
                      ? upComingExamListView
                      : const AppIndecator()),
              // Center(child: Text("No Exam")),
              Center(
                  child: isLoading == false
                      ? completedExamListView
                      : const AppIndecator()),
            ], controller: _tabController))
          ],
        ),
      ),
    );
  }

  ListView get allExamListView {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: allExamList["data"].length,
        itemBuilder: (context, dynamic index) {
          var examData = allExamList["data"][index];
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExamDetails(examData)),
                );
              },
              child: Card(
                color: Constants.whiteGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            examData['name'].toString(),
                            style: const TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            "Publish Date: ${examData['publish_date'] ?? "Not published"}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView get upComingExamListView {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: upcomingExamList.length,
        itemBuilder: (context, dynamic index) {
          var examData = upcomingExamList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExamDetails(examData)),
                );
              },
              child: Card(
                color: Constants.whiteGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            examData['name'].toString(),
                            style: const TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Publish Date: ${examData['publish_date'] ?? "Not published"}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView get completedExamListView {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: completedExamList.length,
        itemBuilder: (context, dynamic index) {
          var examData = completedExamList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExamDetails(examData)),
                );
              },
              child: Card(
                color: Constants.whiteGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            examData['name'].toString(),
                            style: const TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Publish Date: ${examData['publish_date'] ?? "Not published"}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Constants.primaryColor,)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
