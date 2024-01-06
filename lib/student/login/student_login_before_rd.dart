import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class StudentLoginBeforeRd extends StatelessWidget {
  const StudentLoginBeforeRd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Constants.primaryColor.withOpacity(0.1),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          children: [
            Image.asset(
              "assets/logo1.png",
              height: 60,
              width: 60,
            ),
            const Divider(),
            const Text(
              "Bangladesh International School, Dhaka, Bangladesh",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
