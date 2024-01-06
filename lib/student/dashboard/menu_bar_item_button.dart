import 'package:eschoolproject/site_message_details_screen/admission_screen.dart';
import 'package:eschoolproject/student/menu_modal/attendance/student_attendance.dart';
import 'package:eschoolproject/student/menu_modal/class_routine/class_routine.dart';
import 'package:eschoolproject/student/menu_modal/events/event.dart';
import 'package:eschoolproject/student/menu_modal/exams/exam_screen.dart';
import 'package:eschoolproject/student/menu_modal/holidays/holidays.dart';
import 'package:eschoolproject/student/menu_modal/magazine/magazine.dart';
import 'package:eschoolproject/student/menu_modal/notice/notice_board.dart';
import 'package:eschoolproject/student/menu_modal/result/result_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../menu_modal/teachers_feedback/teachers_feedback.dart';

class MenuBarItemButton extends StatelessWidget {
  const MenuBarItemButton(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      required this.imagePath,
      required this.menuItemTitle})
      : super(key: key);
  final double screenWidth;
  final double screenHeight;
  final String menuItemTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(menuItemTitle.toString());
        switch (menuItemTitle) {
          // Your Enum Value which you have passed
          case "Routine":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ClassRoutineScreen()));
            break;
          case "Notice":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NoticeBoardScreen()));
            break;
          //   case "Parent Profile":
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ParentsProfileScreen()));
          //   break;
          case "Attendance":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StudentAttendanceScreen()));
            break;
          //case "Settings":
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
          //   break;
          case "Exams":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ExamScreen()));
            break;
          case "Result":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResultScreen()));
            break;
          case "Holidays":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HolidaysScreen()));
            break;
          case "Magazine":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MagazineScreen()));
            break;
          case "FeedBack":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TeachersFeedback()));
            break;
          case "Events":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EventScreen()));
            break;
          case "Admission":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdmissionDetailScreen()));
            break;
        }
      },
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: screenWidth / 5,
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(imagePath,
                      height: 50, width: 50, color: Colors.white),
                  /*Image(
                    image: AssetImage(imagePath),
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  ),*/
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(menuItemTitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
