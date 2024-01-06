import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/menu_modal/settings/settings_detail_screen.dart';
import 'package:eschoolproject/student/utils/mixins.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            AppDefaultBar(title: "Settings"),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.language_outlined,
                          size: 40,
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Application language",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    //SizedBox(height: 5,),
                    const Divider(
                      thickness: 0.8,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "English",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ))),
                    SizedBox(
                        height: 40,
                        width: screenWidth,
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "More",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ))),
                    const SizedBox(
                      height: 2,
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),

                    Expanded(
                      child: ListView.builder(
                          itemCount: Mixins().settingsItem.length,
                          itemBuilder: (context, int index) {
                            return SizedBox(
                                height: 35,
                                width: screenWidth,
                                child: SettingButton(
                                    settingItemtitle:
                                        "${Mixins().settingsItem.elementAt(index)["title"]}"));
                          }),
                    ),

                    /*
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(
                          onPressed: (){
                            Fluttertoast.showToast(
                                msg: "This is Center Short Toast",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Change password",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicyDetailScreen()));
                        },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Privacy Policy",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(onPressed:(){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Terms & Condition",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 30,
                        width: screenWidth,
                        child: TextButton(onPressed:(){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("About Us",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(onPressed:(){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Contact Us",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(onPressed:(){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Rate Us",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),
                    SizedBox(
                        height: 35,
                        width: screenWidth,
                        child: TextButton(onPressed:(){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Share",
                                  style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),),
                                Icon(Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            )
                        )
                    ),*/
                    FloatingActionButton.extended(
                      label: const Text('Log out'), // <-- Text
                      backgroundColor: Colors.black,
                      icon: const Icon(
                        // <-- Icon
                        Icons.logout,
                        size: 24.0,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  SettingButton({Key? key, required this.settingItemtitle}) : super(key: key);
  String settingItemtitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingItemDetailScreen(
                      settingItemName: settingItemtitle, settingItemLink: '',)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              settingItemtitle,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ));
  }
}
