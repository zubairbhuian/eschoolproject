import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/diary_list_controller.dart';
import 'package:eschoolproject/student/data/network/models/diary_list_model.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubjectsDetailsScreen extends StatefulWidget {
  final String className;
  final String sectionName;
  final String date;

  const SubjectsDetailsScreen({
    Key? key,
    required this.className,
    required this.sectionName,
    required this.date,
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
  List<Dairy> diaryList = [];
  @override
  void didChangeDependencies() {
    diaryListController = Get.put(DiaryListController());
    diaryListController.getDiaryList();
    super.didChangeDependencies();
  }

  // date Formet
  String onDateFormet(String data) {
    return DateFormat('DD-MM-yyyy').format(DateTime.parse(data));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<DiaryListController>(
      init: DiaryListController(),
      builder: (diaries) {
        // var myDate = DateTime.parse(diaryList[0].date!);
        return Scaffold(
            appBar: CustomAppBar(
              title: widget.sectionName,
            ),
            body: GetBuilder<DiaryListController>(builder: (controller) {
              // filter with class section date
              diaryList = controller.diaryList
                  .where((diary) =>
                      diary.className == widget.className &&
                      diary.sectionName == widget.sectionName &&
                      onDateFormet("${diary.date}") ==
                          onDateFormet("${widget.date}"))
                  .toList();
              print(diaryList.length);

              if (controller.loader) {
                return Center(child: AppIndecator());
              }
              if (diaryList.isEmpty) {
                return Center(
                  child: Text("No Data Found"),
                );
              }

              return SingleChildScrollView(
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
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(diaryList.length, (index) {
                      return TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(diaryList[index].subject ?? "",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(diaryList[index].homeWork ?? ""),
                        ),
                      ]);
                    })),
              );
            }));
      },
    );
  }
}
