import 'package:flutter/material.dart';

import '../../../Widget/app_default_bar.dart';
class AdmissionScreen extends StatefulWidget {
  const AdmissionScreen({Key? key}) : super(key: key);

  @override
  State<AdmissionScreen> createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            AppDefaultBar(title: "Admission")
          ],
        ),
      ),
    );
  }
}
