import 'package:eschoolproject/student/subject/subjects_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectItemButton extends StatelessWidget {
  const SubjectItemButton({
    Key? key,
    required this.subjectId,
    required this.subjectTitle,
    required this.imagePath,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String subjectId;
  final String subjectTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SubjectsDetailsScreen(
        //             subjectName: subjectTitle,
        //             subjectId: subjectId,
        //           )),
        // );
      },
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: screenWidth / 5,
              decoration: BoxDecoration(
                color: const Color(0xff002147),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/subject_icon/book.svg",
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  )
                  /* Image(
                    image: AssetImage(imagePath),
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: screenHeight / 300,
            ),
            Expanded(
              child: Text(
                subjectTitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
