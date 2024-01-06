import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class DiariesScreen extends StatefulWidget {
  dynamic diaryData;

  DiariesScreen({Key? key, required this.diaryData}) : super(key: key);

  @override
  State<DiariesScreen> createState() => _DiariesScreenState();
}

class _DiariesScreenState extends State<DiariesScreen> {
  bool isLoading = false;

  // dynamic diaryList;
  dynamic diaryData;

  @override
  void initState() {
    super.initState();
    diaryData = widget.diaryData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoading == true
            ? const Expanded(child: Center(child: CircularProgressIndicator()))
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   color: Constants.primaryColor,
                      //   height: 35,
                      //   width: double.maxFinite,
                      //   alignment: Alignment.center,
                      //   child: const Text("Subject", textAlign: TextAlign.center , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      // ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Subject :",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Constants.primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            diaryData["subject"]["name"].toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Constants.primaryColor),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Teacher:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            diaryData["teacher_name"].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        diaryData["home_work"].toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
