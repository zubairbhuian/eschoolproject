import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/controllers/provide_feedback_controller.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFeedback extends StatefulWidget {
  final String? teacherName;
  const CreateFeedback({Key? key, this.teacherName}) : super(key: key);

  @override
  State<CreateFeedback> createState() => _CreateFeedbackState();
}

class _CreateFeedbackState extends State<CreateFeedback> {
  String? selectedClass = '', selectedSection = '', selectedGroup = '';

  String? selectedClassId = '', selectedSectionId;

  String studentName = '';
  String studentRoll = '';
  String feedback = '';

  final _formKey = GlobalKey<FormState>();

  ProvideFeedbackController provideFeedbackController =
      ProvideFeedbackController();

  bool showGroup = false;

  dynamic classInfoList;
  bool isLoading = false;
  List<dynamic> classes = [];
  List<dynamic> sections = [];
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
        classes = classInfoList['class'];
        print("classes");
        print("classes");
        print("classes");
        print("classes");
        print(classes);
        sections = classInfoList['section'];
      });
    }
  }

  @override
  void didChangeDependencies() {
    provideFeedbackController = Get.put(ProvideFeedbackController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvideFeedbackController>(
      init: ProvideFeedbackController(),
      builder: (feedBack) => Scaffold(
        body: Column(
          children: [
            AppDefaultBar(title: "FeedBack"),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
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
                                  "Select Student Class",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                items: classes.map((item) {
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
                                items: sections.map((section) {
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
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: feedBack.descriptionController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: 'FeedBack',
                                  hintText: 'Enter Your Feedback',
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal),
                                ),
                                onChanged: (String value) {
                                  feedback = value;
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Enter Your Feedback'
                                      : null;
                                },
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: GestureDetector(
                          onTap: () async {
                            feedBack.provideFeedback(
                              context,
                              widget.teacherName.toString(),
                              selectedClassId.toString(),
                              selectedSectionId.toString(),
                              feedBack.descriptionController.text
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
                              child: feedBack.loader == false
                                  ? const Text(
                                      "Submit FeedBack",
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
