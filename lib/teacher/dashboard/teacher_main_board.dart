import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/student/utils/assets.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:eschoolproject/teacher/dashboard/teacher_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../student/dashboard/menu_bar_item_button.dart';
import '../../student/utils/mixins.dart';

class MainBoardTeacher extends StatelessWidget {
  final String? teacherName;
  final String? teacherImage;
  final String? teacherDesignation;
  const MainBoardTeacher(
      {Key? key, this.teacherName, this.teacherImage, this.teacherDesignation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = 0;
    double screenWidth = 0;
    //for floating navbar
    int currentIndex = 0;
    List pages = [TeacherHomeScreen()];

    void onTap(int index) {
      if (index == 1) {
        showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                      const AppIndecator(),
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
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
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(teacherDesignation.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black)),
                                  ],
                                )
                              ],
                            ),
                          )
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
            });
      }
    }

    return Scaffold(
      body: pages[currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.red,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Constants.primaryColor,
          unselectedItemColor: Constants.primaryColor.withOpacity(0.7),
    
          backgroundColor: Colors.blueGrey.shade50,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon:Icon(Icons.menu) , label: 'Menu'),
          ],
        ),
      ),
    );
  }
}
