import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/utils/assets.dart';
import 'package:eschoolproject/teacher/dashboard/submit_assignment/create_assignment.dart';
import 'package:eschoolproject/teacher/dashboard/submit_feedback/create_feedback.dart';
import 'package:eschoolproject/teacher/teacher_menu_modal/teacher_profile/teacher_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../student/login/student_login_before_new.dart';
import '../../student/menu_modal/notice/notice_board.dart';
import '../../student/menu_modal/notice/notice_details_screen.dart';
import '../../student/utils/constants.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool isLoadingNotice = true;
  dynamic noticeList;

  final _myBox = Hive.box('eSchoolBox');

  dynamic teacherName, teacherImage, teacherDesignation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNoticeList();
  }

  Future<dynamic> getNoticeList() async {
    isLoadingNotice = true;
    noticeList = await ApiClient().getData(Endpoints.noticeList);
    if (noticeList == false) {
      isLoadingNotice = true;
    } else {
      setState(() {
        isLoadingNotice = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    teacherName = _myBox.get('teacherName');
    teacherImage = _myBox.get('teacherImage');
    teacherDesignation = _myBox.get('teacherDesignation');
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Constants.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.09,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: teacherImage.toString(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          Assets.personIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        teacherName.toString(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(teacherDesignation.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LogInBeforeNewScreen()),
                          (Route<dynamic> route) => false);
                    },
                    icon: const Icon(Icons.logout, color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAssignment(
                        teacherName: teacherName,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2 - 8,
                  child: Card(
                    margin: const EdgeInsets.all(3.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        //color: Colors.grey.withOpacity(0.5),
                        color: Constants.primaryColor.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          "assets/menu_bar_icon/exam.svg",
                          height: 40,
                          width: 40,
                          color: Constants.primaryColor,
                          fit: BoxFit.cover,
                        ),
                        const Divider(),
                        const Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Submit Diary",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 35,
                          color: Constants.primaryColor,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAssignment(
                                    teacherName: teacherName,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateFeedback(
                        teacherName: teacherName,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2 - 8,
                  child: Card(
                    margin: const EdgeInsets.all(3.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        //color: Colors.grey.withOpacity(0.5),
                        color: Constants.primaryColor.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          "assets/menu_bar_icon/feedback.svg",
                          height: 40,
                          width: 40,
                          color: Constants.primaryColor,
                          fit: BoxFit.cover,
                        ),
                        const Divider(),
                        const Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Submit Feedback",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 35,
                          color: Constants.primaryColor,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateFeedback(
                                    teacherName: teacherName,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Latest Notices",
                style: TextStyle(
                    inherit: false,
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoticeBoardScreen()));
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        isLoadingNotice == true
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: noticeList["data"].length,
                      itemBuilder: (context, int index) {
                        var noticeData = noticeList['data'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoticeDetailsScreen(
                                          noticeTitle: noticeData[index]
                                                  ['title']
                                              .toString(),
                                          noticeDescription: noticeData[index]
                                              ['description'],
                                          noticeDate: noticeData[index]['date']
                                              .toString(),
                                        )));
                          },
                          child: Card(
                              color: Constants.whiteGrey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            noticeData[index]['title']
                                                .toString(),
                                            style: const TextStyle(
                                              color: Constants.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            noticeData[index]['date']
                                                .toString(),
                                            // snapshot.data![index].date!.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                height: 1),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Constants.primaryColor,
                                    )
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              )
      ],
    ));
  }
}
/*
 Container(
        child: Center(
          child: TextButton(onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const LogInBeforeNewScreen()), (Route<dynamic> route) => false);
          },
              child: Text("Log Out")),
        ),
      ),*/
