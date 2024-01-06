import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/utils/mixins.dart';
import 'package:flutter/material.dart';

class ParentsProfileScreen extends StatefulWidget {
  const ParentsProfileScreen({Key? key}) : super(key: key);

  @override
  State<ParentsProfileScreen> createState() => _ParentsProfileScreenState();
}

class _ParentsProfileScreenState extends State<ParentsProfileScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title:"Parent Profile"),
          Flexible(
            child: ListView.builder(
                itemCount:Mixins().parentsInfo.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, int index) {
                  return
                    Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 16, right: 16),
                    child: Container(
                     // height: screenHeight / 1.5,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionalTranslation(
                            translation: const Offset(0.0, -0.4),
                            child: Align(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                  radius: 30.0,
                                  child:  ClipOval(
                                    child: Image(image: AssetImage( "${Mixins().parentsInfo.elementAt(index)["image"]}"),
                                    fit: BoxFit.cover,),
                                  )
                              ),
                              alignment: const FractionalOffset(0.5, 0.0),
                            ),
                          ),
                        //  const SizedBox(),
                          const Divider(
                            thickness: .5,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                    "${Mixins().parentsInfo.elementAt(index)["ParenttypeName"]}",
                                    style: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text("${Mixins().parentsInfo.elementAt(index)["Name"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Date of Birth",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text("${Mixins().parentsInfo.elementAt(index)["DoB"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Email",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text("${Mixins().parentsInfo.elementAt(index)["mail"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Occupation",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                    "${Mixins().parentsInfo.elementAt(index)["occupation"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Phone Number",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                    "${Mixins().parentsInfo.elementAt(index)["PhoneNumber"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Address",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                    "${Mixins().parentsInfo.elementAt(index)["Address"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}