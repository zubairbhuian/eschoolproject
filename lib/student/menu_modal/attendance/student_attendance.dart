import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  DateTime today = DateTime.now();

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  // DateTime today = DateTime.parse("2019-06-27");
  DateTime firstDay = DateTime.utc(2010, 1, 1);
  DateTime lastDay = DateTime.utc(2100);
  double screenHeight = 0;
  double screenWidth = 0;
  bool isLoading = true;
  int totalPresent = 0;

  dynamic attendanceList;
  dynamic attendanceData;

  @override
  void initState() {
    super.initState();
    getAttendance()
        .whenComplete(() => getPresentTotal(today.year, today.month));
  }

  // get attendance data from api
  Future<dynamic> getAttendance() async {
    isLoading = true;
    attendanceList = await ApiClient().getData(
        "${Endpoints.attendanceList}?id_number=${await sharedPreferenceHelper.studentId}");

    print('attendance => $attendanceList');

    if (attendanceList == false) {
      isLoading = true;
    } else {
      attendanceData = attendanceList['data'];
      setState(() {
        isLoading = false;
      });
    }
  }

  void getPresentTotal(int year, int month) {
    totalPresent = 0;
    attendanceData.forEach((data) {
      DateTime date = DateTime.parse(data['access_date'].toString());
      if (date.year == year && date.month == month) {
        totalPresent += 1;
        setState(() {});
      }
      // print(date.month);
      // print(date.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        AppDefaultBar(title: "Attendance"),
        isLoading == true
            ? const Expanded(child: Center(child: AppIndecator()))
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(16)),
                        child: TableCalendar(
                          focusedDay: today,
                          firstDay: firstDay,
                          lastDay: lastDay,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          // onDaySelected: (selectedDay, focusedDay) {
                          //   setState(() {
                          //     print('selectedDay => $selectedDay');
                          //     print('focusedDay => $focusedDay');
                          // });
                          // },

                          onPageChanged: (d) {
                            totalPresent = 0;
                            getPresentTotal(d.year, d.month);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade400),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 25,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Total Present",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Text(
                                        totalPresent.toString(),
                                        style: TextStyle(
                                            color: Colors.green.shade400,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red.shade300),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Total Absent",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                            color: Colors.red.shade300,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )
      ],
    ));
  }
}
