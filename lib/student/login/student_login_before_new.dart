import 'package:eschoolproject/site_message_details_screen/about_school_screen.dart';
import 'package:eschoolproject/site_message_details_screen/admission_screen.dart';
import 'package:eschoolproject/site_message_details_screen/contact_screen.dart';
import 'package:eschoolproject/site_message_details_screen/headmaster_message_screen.dart';
import 'package:eschoolproject/site_message_details_screen/president_message_screen.dart';
import 'package:eschoolproject/student/dashboard/home_work_screen.dart';
import 'package:eschoolproject/student/login/student_login.dart';
import 'package:eschoolproject/student/menu_modal/magazine/magazine.dart';
import 'package:eschoolproject/student/menu_modal/notice/notice_board.dart';
import 'package:eschoolproject/student/menu_modal/result/result_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

import '../data/network/apis/api_client.dart';
import '../data/network/constants/endpoints.dart';

class LogInBeforeNewScreen extends StatefulWidget {
  const LogInBeforeNewScreen({Key? key}) : super(key: key);

  @override
  State<LogInBeforeNewScreen> createState() => _LogInBeforeNewScreenState();
}

class _LogInBeforeNewScreenState extends State<LogInBeforeNewScreen> {
  bool isLoading = false;
  dynamic siteMessageList;
  dynamic siteMessageData;

  @override
  void initState() {
    super.initState();
    getSiteMessage();
  }

  Future<dynamic> getSiteMessage() async {
    isLoading = true;
    siteMessageList = await ApiClient().getData(Endpoints.siteMessageList);

    if (siteMessageList == false) {
      isLoading = true;
    } else {
      siteMessageData = siteMessageList["data"];
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Column(
                    children: [
                      Image(
                        height: 80,
                        width: 80,
                        image: AssetImage(
                          'assets/logo1.png',
                        ),
                      ),
                      Divider(),
                      Align(
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
                      Divider()
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogInBeforeItem(
                          itemTitle: "About School",
                          imagePath: "assets/before_log_in/about_school.png",
                          siteMessageData: siteMessageData),
                      LogInBeforeItem(
                        itemTitle: "President Message",
                        imagePath: "assets/before_log_in/person.png",
                        siteMessageData: siteMessageData,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogInBeforeItem(
                          itemTitle: "Headmaster Message",
                          imagePath: "assets/before_log_in/person.png",
                          siteMessageData: siteMessageData),
                      LogInBeforeItem(
                        itemTitle: "Admission",
                        imagePath: "assets/before_log_in/admission.png",
                        siteMessageData: siteMessageData,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                                            LogInBeforeItem(
                        itemTitle: "Result",
                        imagePath: "assets/menu_bar_icon/result.png",
                        siteMessageData: siteMessageData,
                      ),
                      LogInBeforeItem(
                        itemTitle: "Contact",
                        imagePath: "assets/before_log_in/contact.png",
                        siteMessageData: siteMessageData,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogInBeforeItem(
                        itemTitle: "Diary",
                        imagePath: "assets/menu_bar_icon/diary.png",
                        siteMessageData: siteMessageData,
                      ),
                      LogInBeforeItem(
                        itemTitle: "Notice",
                        imagePath: "assets/menu_bar_icon/notice.png",
                        siteMessageData: siteMessageData,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 46,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentLogin(
                                      logInAs: 'teacher',
                                    )));
                      },
                      child: const Text(
                        'Teacher Login',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    )));
  }
}

class LogInBeforeItem extends StatelessWidget {
  LogInBeforeItem(
      {Key? key,
      required this.itemTitle,
      required this.imagePath,
      required this.siteMessageData})
      : super(key: key);
  final String itemTitle;
  final String imagePath;
  dynamic siteMessageData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (itemTitle) {
          case "Magazine":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MagazineScreen()));
            break;
          case "Admission":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdmissionDetailScreen()));
            break;
          case "Contact":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactScreen()));
            break;
          case "About School":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutSchoolScreen(
                          aboutSchoolData: siteMessageData[0],
                        )));
            break;
          case "Headmaster Message":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HeadmasterMessageScreen(
                          headmasterMessageData: siteMessageData[1],
                        )));
            break;
          case "President Message":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PresidentMessageScreen(
                          presidentMessageData: siteMessageData[2],
                        )));
            break;
          case "Diary":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeWorkScreen()));
            break;
          case "Notice":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NoticeBoardScreen()));
            break;

          case "Result":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResultScreen()));
            break;
        }
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.00),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    //  spreadRadius: 0.05,
                    blurRadius: 1)
              ]),
          child: Stack(
            children: [
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.09,
                  bottom: 00,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Constants.primaryColor),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        itemTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                bottom: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 00,
                            blurRadius: 1)
                      ],
                      color: Colors.white),
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.13,
                    image: AssetImage(
                      imagePath,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
