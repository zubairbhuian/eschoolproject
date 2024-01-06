import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../student/login/student_login_before_new.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LogInBeforeNewScreen()),
                    (Route<dynamic> route) => false);
              },
              child: const Text("Log Out")),
        ),
      ),
    );
  }
}
