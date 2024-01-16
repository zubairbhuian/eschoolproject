import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/diary_list_controller.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubjectsDetailsScreen extends StatefulWidget {
  final String subjectName;
  final String subjectId;

  const SubjectsDetailsScreen({
    required this.subjectName,
    required this.subjectId,
    Key? key,
  }) : super(key: key);

  @override
  State<SubjectsDetailsScreen> createState() => _SubjectsDetailsScreenState();
}

class _SubjectsDetailsScreenState extends State<SubjectsDetailsScreen> {
  double screenWidth = 0;
  double screenHeight = 0;
  bool isLoading = false;

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  DiaryListController diaryListController = DiaryListController();

  @override
  void didChangeDependencies() {
    diaryListController = Get.put(DiaryListController());
    diaryListController.getDiaryList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<DiaryListController>(
      init: DiaryListController(),
      builder: (diaries) {
        final diaryList = diaries.diaryList
            .where((diary) => diary.id == widget.subjectId)
            .toList();
        var myDate = DateTime.parse(diaryList[0].date!);
        return Scaffold(
            body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              AppDefaultBar(title: widget.subjectName),
              const SizedBox(
                height: 5,
              ),
              diaries.loader == true
                  ? const Expanded(
                      child: Center(child: AppIndecator()))
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              border: TableBorder.all(),
                              columnWidths: <int, TableColumnWidth>{
                                0: FixedColumnWidth(120),
                                1: FlexColumnWidth()
                                // : const IntrinsicColumnWidth(),
                                // 1: FlexColumnWidth(),
                                // 1: FixedColumnWidth(m.xl ? 200 : 364),
                                // 2: FlexColumnWidth(),
                                // 3: FlexColumnWidth(),
                                // 4: FlexColumnWidth(),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                // date
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${DateFormat('DD-MM-yyyy').format(myDate)}"),
                                  ),
                                ]),
                                // Day
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Day",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        ' ${DateFormat('EEEE').format(myDate)}'),
                                  ),
                                ]),
                                // class ID
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Class ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].classId}'),
                                  ),
                                ]),
                                // className
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Class Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].className}'),
                                  ),
                                ]),
                                // sectionId
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Section Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].sectionId}'),
                                  ),
                                ]),
                                // sectionName
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Section Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].sectionName}'),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Teacher Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].groupId}'),
                                  ),
                                ]),
                                //sessionId
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Session Id",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].sessionId}'),
                                  ),
                                ]),
                                //Start Date
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Start Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        ' ${DateFormat('DD-MM-yyyy').format(DateTime.parse(diaryList[0].start!))}'),
                                  ),
                                ]),
                                //End Date
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("End Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        ' ${DateFormat('DD-MM-yyyy').format(DateTime.parse(diaryList[0].end!))}'),
                                  ),
                                ]),
                                // teacherName
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Teacher Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].teacherName}'),
                                  ),
                                ]),
                                // subject
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Subject",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].subject}'),
                                  ),
                                ]),
                                // homeWork
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("HomeWork",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(' ${diaryList[0].homeWork}'),
                                  ),
                                ]),
                              ],
                            )),
                      ),
                    ),
            ],
          ),
        ));
      },
    );
  }
}
