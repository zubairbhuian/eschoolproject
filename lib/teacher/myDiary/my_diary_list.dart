import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/diary_list_controller.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyWidget extends StatefulWidget {
  final String name;
  const MyWidget({super.key, required this.name});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
      appBar: CustomAppBar(title: "My Diary"),
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
                                  "ID ${diaryList[index].id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
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
                        // date
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Date",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${onDateFormet("${diaryList[index].date}")}"),
                          ),
                        ]),
                        // Day
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Day",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child:
                                Text(' ${DateFormat('EEEE').format(DateTime.parse("${diaryList[index].date}"))}'),
                          ),
                        ]),
                        // class ID
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Class ID",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(' ${diaryList[0].classId}'),
                        //   ),
                        // ]),
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
                        // sectionId
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Section Name",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(' ${diaryList[0].sectionId}'),
                        //   ),
                        // ]),
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
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Teacher Name",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(' ${diaryList[0].teacherName}'),
                        //   ),
                        // ]),
                        //sessionId
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Session Id",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(' ${diaryList[0].sessionId}'),
                        //   ),
                        // ]),
                        // //Start Date
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Start Date",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(
                        //         ' ${DateFormat('DD-MM-yyyy').format(DateTime.parse(diaryList[0].start!))}'),
                        //   ),
                        // ]),
                        // //End Date
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("End Date",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(
                        //         ' ${DateFormat('DD-MM-yyyy').format(DateTime.parse(diaryList[0].end!))}'),
                        //   ),
                        // ]),
                        // // teacherName
                        // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Teacher Name",
                        //         style: TextStyle(fontWeight: FontWeight.w500)),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(' ${diaryList[0].teacherName}'),
                        //   ),
                        // ]),
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
