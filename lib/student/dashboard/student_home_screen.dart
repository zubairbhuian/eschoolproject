import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/student/data/local/local_client.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:eschoolproject/student/menu_modal/notice/notice_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import '../data/network/apis/api_client.dart';
import '../data/network/constants/endpoints.dart';
import '../data/sharepref/constants/preferences.dart';
import '../menu_modal/notice/notice_details_screen.dart';
import '../profile/student_profile.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  bool isLoadingStudent = true;
  bool isLoadingNotice = true;
  dynamic noticeList;
  dynamic studentProfileList;
  dynamic student;

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  LocalClient localClient = LocalClient();
  final _myBox = Hive.box('eSchoolBox');

  @override
  void initState() {
    super.initState();
    getNotice().then((value) => getStudentProfile());
  }

  Future<dynamic> getNotice() async {
    isLoadingNotice = true;

    noticeList =
        await localClient.getLocalStorageWithExpiry(Preferences.noticeList);

    if (noticeList == null) {
      noticeList = await ApiClient().getData(Endpoints.noticeList);
      localClient.setLocalStorageWithExpiry(
          Preferences.noticeList, noticeList, 3600000);
    } else {
      noticeList = jsonDecode(noticeList);
    }

    // dev.log(noticeList.toString());

    // print(noticeList['data']);
    if (noticeList == false) {
      isLoadingNotice = true;
    } else {
      setState(() {
        isLoadingNotice = false;
      });
    }
  }

  Future<dynamic> getStudentProfile() async {
    isLoadingStudent = true;

    studentProfileList =
        await localClient.getLocalStorageWithExpiry(Preferences.studentProfile);

    if (studentProfileList == null) {
      studentProfileList = await ApiClient().getData(
          "${Endpoints.studentProfile}?id_number=${await sharedPreferenceHelper.studentId}");
      localClient.setLocalStorageWithExpiry(
          Preferences.studentProfile, studentProfileList, 86400000);
    } else {
      studentProfileList = jsonDecode(studentProfileList);
    }

    if (studentProfileList == false) {
      isLoadingStudent = true;
    } else {
      setState(() {
        isLoadingStudent = false;
      });
      student = studentProfileList["data"];
      _myBox.put(
          'studentClsId', studentProfileList["data"]["exam_class"]["id"]);
      _myBox.put(
          'studentSectionId', studentProfileList["data"]["section"]["id"]);
    }
  }

  // int _current = 0;
  // final CarouselController _carouselController = CarouselController();
  double screenHeight = 0;
  double screenWidth = 0;

  /*List<Widget> generateImageTiles() {
    return Mixins()
        .sliderImages
        .map((element) => ClipRRect(
              child: Image.asset(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ))
        .toList();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Constants.primaryColor,
            ),
            child: isLoadingStudent == true
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                          studentData: student,
                                        )),
                              );
                            },
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.09,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: student['image_url'].toString(),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        SvgPicture.asset(
                                      Assets.personIcon,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        // const StudentImage(picAddress: "assets/profile1.png"),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                student["name"].toString(),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                      "Class : ${student["exam_class"]["name"]} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(width: 4),
                                  Text("|",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Roll No : ${student["class_roll"]} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(width: 4),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text("Section : ${student["section"]["name"]} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          // TextButton(onPressed: (){
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => GridTest()));
          // }, child: Text("Testing")),
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
                                            noticeDate: noticeData[index]
                                                    ['date']
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
      ),
    );
  }
}
