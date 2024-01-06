import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:flutter/material.dart';

class DiaryDetails extends StatefulWidget {
  final String? teacherName;
  final String? diary;
  final String? subject;
  const DiaryDetails({Key? key, this.teacherName, this.diary, this.subject})
      : super(key: key);

  @override
  State<DiaryDetails> createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            AppDefaultBar(title: widget.subject.toString()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Teacher's name: ${widget.teacherName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Diary",
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
                        "${widget.diary}",
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
