import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/submit_diary_controller.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../student/utils/constants.dart';

class CreateAssignment extends StatefulWidget {
  final String? teacherName;
  const CreateAssignment({Key? key, this.teacherName}) : super(key: key);

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  String? selectedSession = '',
      selectedClass = '',
      selectedSection = '',
      selectedGroup = '';

  String? selectedSessionId = '', selectedClassId = '', selectedSectionId;

  String studentName = '';
  String studentRoll = '';
  String assignmentDescription = '';

  final _formKey = GlobalKey<FormState>();

  SubmitDiaryController submitDiaryController = SubmitDiaryController();
  // show group or not
  bool showGroup = false;
  dynamic classInfoList;
  bool isLoading = false;

  List<dynamic> sessions = [];
  List<dynamic> classes = [];
  List<dynamic> sections = [];
  List<dynamic> filteredClasses = [];
  List<dynamic> filteredSections = [];

  @override
  void initState() {
    getClassInfoList();
    super.initState();
  }

  Future<dynamic> getClassInfoList() async {
    isLoading = true;
    classInfoList =
        await ApiClient().getData("https://noaparaideal.site/api/class-list");

    if (classInfoList == null) {
      isLoading = true;
    } else {
      setState(() {
        isLoading = false;
        sessions = classInfoList['sessions'];
        classes = classInfoList['class'];
        sections = classInfoList['section'];
      });
    }
  }

  @override
  void didChangeDependencies() {
    submitDiaryController = Get.put(SubmitDiaryController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(classInfoList);

    return GetBuilder<SubmitDiaryController>(
      init: SubmitDiaryController(),
      builder: (addDiary) => Scaffold(
        body: Column(
          children: [
            AppDefaultBar(title: "Assignment"),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                buttonStyleData: const ButtonStyleData(
                                  height: 60,
                                  padding: EdgeInsets.only(left: 00, right: 10),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  "Select Session",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                items: sessions.map((item) {
                                  final sessionId = item['id'].toString();
                                  final sessionStart = item['start'].toString();
                                  final sessionEnd = item['end'].toString();
                                  return DropdownMenuItem(
                                      value: sessionId,
                                      child: Text(
                                        '$sessionStart - $sessionEnd',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  // print('value => $value');
                                  selectedSessionId = value.toString();
                                  selectedSession = sessions
                                      .firstWhere((item) =>
                                          item['id']?.toString() ==
                                          value.toString())?['start']
                                      ?.toString();

                                  filteredClasses = classes
                                      .where((section) =>
                                          section['session_id'] ==
                                          selectedSessionId)
                                      .toList();

                                  selectedClass = null;
                                  selectedClassId = null;

                                  setState(() {});

                                  print(selectedSessionId);
                                  print(selectedSession);
                                  print(filteredClasses);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Session';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  selectedSessionId = value.toString();
                                  filteredClasses = classes
                                      .where((section) =>
                                          section['session_id'] ==
                                          selectedSessionId)
                                      .toList();
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                buttonStyleData: const ButtonStyleData(
                                  height: 60,
                                  padding: EdgeInsets.only(left: 00, right: 10),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  "Select Student Class",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                items: filteredClasses.map((item) {
                                  final classId = item['id'].toString();
                                  final className = item['name'].toString();
                                  return DropdownMenuItem(
                                      value: classId,
                                      child: Text(
                                        className,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  // print('value => $value');
                                  selectedClassId = value.toString();
                                  selectedClass = classes
                                      .firstWhere((item) =>
                                          item['id']?.toString() ==
                                          value.toString())?['name']
                                      ?.toString();

                                  filteredSections = sections
                                      .where((section) =>
                                          section['exam_class_id'] ==
                                          selectedClassId)
                                      .toList();

                                  selectedSection = null;
                                  selectedSectionId = null;

                                  setState(() {});

                                  print(selectedClassId);
                                  print(selectedClass);
                                  print(filteredSections);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Student Class';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  selectedClassId = value.toString();
                                  filteredSections = sections
                                      .where((section) =>
                                          section['exam_class_id'] ==
                                          selectedClassId)
                                      .toList();
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                value: selectedSectionId,
                                buttonStyleData: const ButtonStyleData(
                                  height: 60,
                                  padding: EdgeInsets.only(left: 00, right: 10),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  "Select Student Section",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                items: filteredSections.map((section) {
                                  final sectionId = section['id'].toString();
                                  final sectionName =
                                      section['name'].toString();
                                  return DropdownMenuItem(
                                      value: sectionId,
                                      child: Text(
                                        sectionName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  selectedSectionId = value.toString();
                                  selectedSection = filteredSections
                                      .firstWhere((section) =>
                                          section['id']?.toString() ==
                                          value.toString())?['name']
                                      ?.toString();

                                  setState(() {});

                                  print(selectedSectionId);
                                  print(selectedSection);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Student Section';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  selectedSectionId = value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: addDiary.subjectController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: 'Subject',
                                  hintText: 'Enter Subject',
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                ),
                                onChanged: (String value) {
                                  studentRoll = value;
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Enter Subject'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: addDiary.homeWorkController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: 'Diary',
                                  hintText: 'Enter Diary',
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                ),
                                onChanged: (String value) {
                                  assignmentDescription = value;
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Enter Your Diary'
                                      : null;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                          onTap: () async {
                            addDiary.submitDairy(
                              context,
                              widget.teacherName.toString(),
                              selectedSessionId.toString(),
                              selectedClassId.toString(),
                              selectedSectionId.toString(),
                              addDiary.subjectController.text.toString().trim(),
                              addDiary.homeWorkController.text
                                  .toString()
                                  .trim(),
                            );
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.primaryColor),
                            child: Center(
                              child: addDiary.loader == false
                                  ? const Text(
                                      "Submit Diary",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Center(
                                      child: LoadIndecator(),
                                    ),
                            ),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
