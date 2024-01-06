import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:flutter/material.dart';

class TeachersFeedbackDetails extends StatelessWidget {
  final String? teacherName;
  final String? teacherFeedback;
  const TeachersFeedbackDetails(
      {Key? key, this.teacherName, this.teacherFeedback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            AppDefaultBar(title: "FeedBack Details"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Teacher's name: $teacherName",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "FeedBack",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(
                          thickness: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$teacherFeedback",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
