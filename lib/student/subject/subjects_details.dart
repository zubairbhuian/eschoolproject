// import 'package:eschoolproject/Widget/app_default_bar.dart';
// import 'package:eschoolproject/controllers/diary_list_controller.dart';
// import 'package:eschoolproject/student/data/sharepref/shared_preference_helper.dart';
// import 'package:eschoolproject/student/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
//
// import '../data/network/apis/api_client.dart';
// import '../data/network/constants/endpoints.dart';
// import 'chapter/chapterdetails.dart';
// import 'diary_details.dart';
//
// class SubjectsDetailsScreen extends StatefulWidget {
//   final String subjectName;
//   final String subjectId;
//
//   const SubjectsDetailsScreen({
//     required this.subjectName,
//     required this.subjectId,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<SubjectsDetailsScreen> createState() => _SubjectsDetailsScreenState();
// }
//
// class _SubjectsDetailsScreenState extends State<SubjectsDetailsScreen> {
//   double screenWidth = 0;
//   double screenHeight = 0;
//   bool isLoading = false;
//
//   SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
//   DiaryListController diaryListController = DiaryListController();
//   final _myBox = Hive.box('eSchoolBox');
//
//   @override
//   void didChangeDependencies() {
//     diaryListController = Get.put(DiaryListController());
//     diaryListController.getDiaryList(
//         _myBox.get('studentClsId'), _myBox.get('studentSectionId'));
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     return GetBuilder<DiaryListController>(
//       init: DiaryListController(),
//       builder: (diaries) {
//         final diaryList = diaries.diaryList
//             .where((diary) => diary.subjectId == widget.subjectId)
//             .toList();
//         return Scaffold(
//             body: SizedBox(
//           width: screenWidth,
//           height: screenHeight,
//           child: Column(
//             children: [
//               AppDefaultBar(title: widget.subjectName),
//               const SizedBox(
//                 height: 5,
//               ),
//               diaries.loader == true
//                   ? const Expanded(
//                       child: Center(child: CircularProgressIndicator()))
//                   : Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListView.builder(
//                             padding: EdgeInsets.zero,
//                             scrollDirection: Axis.vertical,
//                             itemCount: diaryList.length,
//                             itemBuilder: (context, int index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   Get.to(
//                                     () => DiaryDetails(
//                                       subject: widget.subjectName.toString(),
//                                       diary: diaryList[index]
//                                           .description
//                                           .toString(),
//                                       teacherName:
//                                           diaryList[index].name.toString(),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   color: Constants.whiteGrey,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Text(
//                                               diaryList[index]
//                                                   .description
//                                                   .toString(),
//                                               style: const TextStyle(
//                                                 color: Constants.primaryColor,
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             const SizedBox(height: 5),
//                                             Text(
//                                               "Teacher Name:${diaryList[index].name}",
//                                               style: const TextStyle(
//                                                 color: Constants.primaryColor,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const Icon(
//                                           Icons.arrow_forward_ios,
//                                           color: Constants.primaryColor,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//             ],
//           ),
//         ));
//       },
//     );
//   }
// }
