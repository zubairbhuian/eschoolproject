import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
import 'package:eschoolproject/student/dashboard/student_home_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../data/network/apis/api_client.dart';
import '../data/network/constants/endpoints.dart';
import '../utils/assets.dart';
import 'home_work_screen.dart';
import '../utils/mixins.dart';
import 'menu_bar_item_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double screenHeight = 0;
  double screenWidth = 0;

  int currentIndex = 0;

  List pages = [
    const StudentHomeScreen(),
    // const HomeWorkScreen(),
  ];

  bool isLoading = false;
  dynamic studentProfile;
  dynamic student;
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  final _myBox = Hive.box('eSchoolBox');

  @override
  void initState() {
    super.initState();
    getStudentProfile();
  }

  Future<dynamic> getStudentProfile() async {
    isLoading = true;
    studentProfile = await ApiClient().getData(
        "${Endpoints.studentProfile}?id_number=${await sharedPreferenceHelper.studentId}");

    if (studentProfile == null) {
      isLoading = true;
    } else {
      student = studentProfile['data'];
      setState(() {
        isLoading = false;
      });
      if (studentProfile['data']['exam_class_id'] != null) {
        _myBox.put('classId', studentProfile['data']['exam_class_id']);
        _myBox.put('className', studentProfile['data']['exam_class']['name']);
      }
      if (studentProfile['data']['section_id'] != null) {
        _myBox.put('sectionId', studentProfile['data']['section_id']);
        _myBox.put('sectionName', studentProfile['data']['section']['name']);
      }
    }
  }

  void onTap(int index) {
    if (index == 2) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          screenHeight = MediaQuery.of(context).size.height;
          screenWidth = MediaQuery.of(context).size.width;
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                children: [
                  isLoading == true
                      ? const CircularProgressIndicator()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile()),);
                                },
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.09,
                                  backgroundColor: Colors.grey,
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: 75,
                                      width: 75,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            student['image_url'].toString(),
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
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    student["name"].toString(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                          "Class :  ${student["exam_class"]["name"]} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black)),
                                      const SizedBox(width: 4),
                                      Text("|",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black)),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Roll No :  ${student["class_roll"]} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "Section : ${student["section"]["name"]} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.black)),
                                ],
                              ),
                            ),
                            //   const SizedBox(width: 30),
                            // IconButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const StudentProfile()),
                            //       );
                            //     },
                            //     icon: const Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 120,
                        ),
                        itemCount: Mixins().mainMenuItem.length,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return MenuBarItemButton(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            imagePath:
                                ("${Mixins().mainMenuItem.elementAt(index)["images"]}"),
                            menuItemTitle:
                                ("${Mixins().mainMenuItem.elementAt(index)["title"]}"),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      );
      return;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        extendBody: true,
        bottomNavigationBar: FloatingNavbar(
          width: 350,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Constants.whiteColor,
          unselectedItemColor: Constants.whiteColor.withOpacity(0.7),
          selectedBackgroundColor: Colors.transparent,
          backgroundColor: Constants.blackColor,
          borderRadius: 10,
          fontSize: 15,
          items: [
            FloatingNavbarItem(
              icon: Icons.home,
              title: 'Home',
            ),
            FloatingNavbarItem(icon: Icons.assignment, title: 'Diary'),
            FloatingNavbarItem(icon: Icons.menu, title: 'Menu'),
          ],
        ));
  }
}
