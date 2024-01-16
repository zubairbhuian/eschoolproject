import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../Widget/app_default_bar.dart';

class ExamDetails extends StatefulWidget {
 final dynamic examData;

  ExamDetails(this.examData, {Key? key}) : super(key: key);

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  dynamic examData;
  dynamic routineList;

  @override
  void initState() {
    super.initState();
    examData = widget.examData;
    routineList = examData['routine'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: examData['name'].toString()),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: routineList.length,
                itemBuilder: (context, dynamic index) {
                  var routineData = routineList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      color: Constants.whiteGrey,
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Subject Name : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(routineData['subject']['name'].toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Constants.primaryColor,
                                          fontWeight: FontWeight.bold,),
                                    ),
                                ),

                              ],
                            ),

                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Date : ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(routineData['date'].toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Starting Time :",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(routineData['time'].toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Mark :",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(routineData['subject']["full_mark"].toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
