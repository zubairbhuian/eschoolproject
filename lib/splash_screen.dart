import 'dart:async';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:eschoolproject/student/login/student_login_before_new.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:eschoolproject/teacher/dashboard/teacher_main_board.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool auth = false;
  bool isLogin = false;
  String logInAs = '';
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  void initState() {
    // implement initState
    getIsLogin().whenComplete(() => startTime());

    super.initState();
  }

  Future<void> getIsLogin() async {
    isLogin = await sharedPreferenceHelper.isLoggedIn;
    logInAs = await sharedPreferenceHelper.logInAs ?? '';

    // print('isLogin => $isLogin');
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => isLogin
                ? const MainBoardTeacher()
                : const LogInBeforeNewScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.whiteColor,
      child: Center(
        child: Image.asset(
          'assets/logo1.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
