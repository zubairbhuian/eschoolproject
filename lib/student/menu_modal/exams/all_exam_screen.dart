import 'package:eschoolproject/student/menu_modal/exams/exam_details_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class AllExamScreen extends StatefulWidget {
 final dynamic allExamList;
 const AllExamScreen(this.allExamList, {Key? key}) : super(key: key);

  @override
  State<AllExamScreen> createState() => _AllExamScreenState();
}

class _AllExamScreenState extends State<AllExamScreen> {
  bool isLoading = false;
  dynamic allExamList;

  @override
  void initState() {
    allExamList = widget.allExamList;
    super.initState();
  }

  // Future<dynamic> getAllExam() async {
  //   isLoading = true;
  //   allExamList = await ApiClient().getList(Endpoints.examList);
  //
  //   if (allExamList == false) {
  //     isLoading = true;
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allExamList["data"].length,
                    itemBuilder: (context, dynamic index) {
                      var examData = allExamList["data"][index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExamDetails(examData)),
                            );
                          },
                          child: Card(
                            color: Constants.secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    examData['name'].toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(
                                    height: 4,
                                  ),
                                  Text(
                                    "Publish Date: ${examData['publish_date'] ?? "Not published"}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),

                                  /*Text(
                           examData[index]['routine'].date!.toString(),
                           style: const TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                           ),

                       ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
      ],
    ));
  }
}
