import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:eschoolproject/teacher/dashboard/teacher_main_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../dashboard/main_page.dart';
import '../data/network/apis/api_client.dart';
import '../data/network/constants/endpoints.dart';

class StudentLogin extends StatefulWidget {
  String logInAs;

  StudentLogin({Key? key, required this.logInAs}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  double screenHeight = 0;
  double screenWidth = 0;
  final TextEditingController _IdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String studentId = '';
  String password = '';
  //for teacher
  dynamic teacherLoginInfo;

  bool isLoading = false;
  dynamic studentLoginInfo;
  bool loginSuccessful = false;

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  final _myBox = Hive.box('eSchoolBox');

  Future<dynamic> getStudentLogin(studentId, password) async {
    setState(() {
      isLoading = true;
    });
    studentLoginInfo = await ApiClient().getData(
        "${Endpoints.studentLogin}?id_number=$studentId&password=$password");

    if (studentLoginInfo == false) {
      Get.rawSnackbar(
          message: 'Something is wrong, try again',
          backgroundColor: Colors.red);
    } else {
      loginSuccessful = studentLoginInfo['success'];
      print('studentLoginInfo => $studentLoginInfo');

      if (loginSuccessful) {
        sharedPreferenceHelper.saveIsLoggedIn(loginSuccessful);
        sharedPreferenceHelper.saveStudentId(studentId);
        sharedPreferenceHelper.saveLogInAs(widget.logInAs);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> getTeacherLogin(studentId) async {
    setState(() {
      isLoading = true;
    });
    //  teacherLoginInfo = await ApiClient().getData("https://new.maphsctg.edu.bd/api/teacher/login?email=$studentId&password=$password");
    teacherLoginInfo = await ApiClient().getData(
        "https://noaparaideal.site/api/teacher-logins?id_number=$studentId");
    print("studentId=>$studentId");
    print("login=>$teacherLoginInfo");
    if (teacherLoginInfo == false) {
      Get.rawSnackbar(
          message: 'Something is wrong, try again',
          backgroundColor: Colors.red);
    } else {
      loginSuccessful = teacherLoginInfo["success"];
      print("loginas=>$teacherLoginInfo");
      if (loginSuccessful) {
        sharedPreferenceHelper.saveIsLoggedIn(loginSuccessful);
        sharedPreferenceHelper.saveTeacherId(studentId);
        sharedPreferenceHelper.saveLogInAs(widget.logInAs);
        _myBox.put('teacherName', teacherLoginInfo["data"]["name"]);
        _myBox.put(
            'teacherDesignation', teacherLoginInfo["data"]["designation"]);
        _myBox.put('teacherImage', teacherLoginInfo["data"]["image_url"]);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainBoardTeacher(
              teacherName: teacherLoginInfo["data"]["name"],
              teacherImage: teacherLoginInfo["data"]["image_url"],
              teacherDesignation: teacherLoginInfo["data"]["designation"],
            ),
          ),
        );
      }
    }

    /* sharedPreferenceHelper.saveIsLoggedIn(true);
    sharedPreferenceHelper.saveTeacherId(studentId);
    sharedPreferenceHelper.saveLogInAs(widget.logInAs);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MainBoardTeacher()));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Image(
                height: 80,
                width: 80,
                image: AssetImage(
                  'assets/logo1.png',
                ),
              ),
              const Divider(),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Noapara Ideal School",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff002147)),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const Text(
                "Let'" "s Sign in",
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(
                height: 26,
              ),
              TextField(
                controller: _IdController,
                style: const TextStyle(
                    fontSize: 20,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 16, top: 16, bottom: 16, right: 16),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: widget.logInAs == "student"
                      ? "Student Id Number"
                      : "Teacher Email Id ",
                  hintStyle: const TextStyle(fontSize: 20),
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Constants.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.secondaryColor, width: 40.00),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              widget.logInAs == "student"
                  ? TextField(
                      controller: _passwordController,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold),
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 16, right: 16),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Password",
                        suffixIcon: const Icon(
                          Icons.lock,
                          color: Constants.primaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.secondaryColor, width: 40.00),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  : Container(),
              widget.logInAs == "student"
                  ? const SizedBox(height: 4)
                  : Container(),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       textStyle: const TextStyle(fontSize: 16),
              //       foregroundColor: Constants.primaryColor,
              //     ),
              //     onPressed: () {
              //       // print("Not Now");
              //     },
              //     child: const Text('Reset Password?'),
              //   ),
              // ),
              // const SizedBox(height: 4),
              SizedBox(
                width: double.maxFinite,
                height: 46,
                child: OutlinedButton(
                  onPressed: () {
                    // print('${_studentIdController.text} and ${_passwordController.text}');
                    widget.logInAs == "student"
                        ? getStudentLogin(_IdController.text.toString(),
                            _passwordController.text.toString())
                        : getTeacherLogin(_IdController.text.toString());
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                  },
                  child: const Text(
                    'Log  In ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "By logging in, you agree to our",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Constants.greyColor),
              ),
              const SizedBox(
                height: 4,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Terms & Condition',
                    style:
                        TextStyle(fontSize: 16, color: Constants.primaryColor),
                  ),
                  Text(
                    " and ",
                    style:
                        TextStyle(fontSize: 16, color: Constants.primaryColor),
                  ),
                  Text(
                    'Privacy Policy',
                    style:
                        TextStyle(fontSize: 16, color: Constants.primaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
