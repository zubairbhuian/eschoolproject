import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/controllers/diary_list_controller.dart';
import 'package:eschoolproject/student/data/local/local_client.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../subject/subjects_details.dart';

class HomeWorkScreen extends StatefulWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);

  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  LocalClient localClient = LocalClient();

  bool isLoading = false;
  dynamic subjectList;
  DiaryListController diaryListController = DiaryListController();
  final _myBox = Hive.box('eSchoolBox');
  List<String> selectedClasses = [];

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
        final filteredDiaries = diaries.diaryList.where((cls) {
          return selectedClasses.isEmpty ||
              selectedClasses.contains(cls.className);
        }).toList();
        return Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0)),
              ),
              backgroundColor: Constants.primaryColor,
              title: const Text(
                'Diaries',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.normal),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            body: diaries.loader == true
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: diaries.classList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: FilterChip(
                                  label: Text(
                                      diaries.classList[index].name.toString()),
                                  selected: selectedClasses
                                      .contains(diaries.classList[index].name),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedClasses.add(
                                          diaries.classList[index].name
                                              .toString(),
                                        );
                                      } else {
                                        selectedClasses.remove(
                                          diaries.classList[index].name
                                              .toString(),
                                        );
                                      }
                                    });
                                  }),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: filteredDiaries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Constants.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Constants.greyColor,
                                        offset: Offset.fromDirection(2.0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Date: ${filteredDiaries[index].date}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Class: ${filteredDiaries[index].className}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Section: ${filteredDiaries[index].sectionName}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Diary Title: ${filteredDiaries[index].homeWork}'),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => SubjectsDetailsScreen(
                                          //             subjectName: diaries
                                          //                 .subjectList[index].name
                                          //                 .toString(),
                                          //             subjectId: diaries.subjectList[index].id
                                          //                 .toString(),
                                          //           )),
                                          // );
                                        },
                                        child: const Text(
                                          'Details',
                                          style: TextStyle(
                                              color: Constants.whiteColor),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Constants.greyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}
