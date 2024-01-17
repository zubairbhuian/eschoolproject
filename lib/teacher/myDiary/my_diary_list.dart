import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/diary_list_controller.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:eschoolproject/teacher/myDiary/edite_my_diary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyDiaryScreen extends StatefulWidget {
  final String name;
  const MyDiaryScreen({super.key, required this.name});

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  DiaryListController diaryListController = DiaryListController();
  // List<String> selectedClasses = [];

  @override
  void didChangeDependencies() {
    diaryListController = Get.put(DiaryListController());
    diaryListController.getDiaryList();
    super.didChangeDependencies();
  }

  var diaryList = [];
  String onDateFormet(String data) {
    return DateFormat('DD-MM-yyyy').format(DateTime.parse(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Diary"),
      body: GetBuilder<DiaryListController>(builder: (controller) {
        var now = DateTime.now();
        var diaryList = controller.diaryList
            .where((diary) =>
                diary.teacherName == widget.name &&
                onDateFormet("${diary.date!}") == onDateFormet("${now}"))
            .toList();

        if (controller.loader)
          return Center(
            child: AppIndecator(),
          );
        if (diaryList.isEmpty)
          return Center(
            child: Text("No data Found"),
          );
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            children: List.generate(diaryList.length, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    // header
                    Container(
                      color: Constants.primaryColor,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "${onDateFormet("${diaryList[index].date}")}-${DateFormat('EEEE').format(DateTime.parse("${diaryList[index].date}"))}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  //!  routung
                                  Get.to(() => EditeMyDiary(
                                    id: diaryList[index].id??"",
                                    sessionId: diaryList[index].sessionId??"",
                                    classId: diaryList[index].classId??"",
                                    sectionId: diaryList[index].sectionId??"",
                                    subject: diaryList[index].subject??"",
                                    homeWork: diaryList[index].homeWork??"",
                                  ));
                                },
                                icon: Icon(
                                  Icons.edit_note,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: <int, TableColumnWidth>{
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth()
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                       
                        // className
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Class Name",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(' ${diaryList[0].className}'),
                          ),
                        ]),
                       
                        // sectionName
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Section Name",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(' ${diaryList[0].sectionName}'),
                          ),
                        ]),
                       
                        // subject
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Subject",
                                style: TextStyle(fontWeight: FontWeight.w500)),
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
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(' ${diaryList[0].homeWork}'),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
