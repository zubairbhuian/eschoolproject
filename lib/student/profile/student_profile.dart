import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/student/login/student_login_before_new.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widget/app_default_bar.dart';
import '../utils/assets.dart';

class StudentProfile extends StatefulWidget {
  dynamic studentData;
 StudentProfile({Key? key,
  required this.studentData
  }) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  double screenWidth = 0;
  double screenHeight = 0;
  bool isLoading = false;
  dynamic studentProfile;
  dynamic student;
  //String studentId = "6B001";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student=widget.studentData;
  }

 /* Future<dynamic> getStudentProfile() async {
    isLoading = true;
    studentProfile = await ApiClient()
        .getData("${Endpoints.studentProfile}?id_number=$studentId");

    if (studentProfile == false) {
      isLoading = true;
    } else {
      student = studentProfile['data'];
      setState(() {
        isLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            AppDefaultBar(
              title: "Profile",
            ),
            isLoading == true
                ? const Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                  child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 16,
                        ),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.09,
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: SizedBox(
                              height: 75,
                              width: 75,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: student['image_url'].toString(),
                                placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
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
                        const SizedBox(
                          height: 16,
                        ),

                        Text(student["name"].toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Card ID: ${student["card_id"]}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                        const Divider(),
                        const Text(
                          "Personal Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Class",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["exam_class"]["name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Section",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["section"]["name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Class Roll",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["class_roll"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Date Of Birth",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["dob"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Gender",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["gender"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Religion",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["religion"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Father Name",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["fathers_name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Mother Name",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["mothers_name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Phone Number",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          student["phone"] ?? "Not found",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:5,
                                    ),
                                    const Divider(),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child:  SizedBox(
                width: double.maxFinite,
                height: 46,
                child: OutlinedButton(
                  onPressed: () async{
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      const LogInBeforeNewScreen()), (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Log  Out',
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
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
