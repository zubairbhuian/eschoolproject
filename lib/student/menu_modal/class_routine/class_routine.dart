import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/controllers/routine_list_controller.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:eschoolproject/student/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClassRoutineScreen extends StatefulWidget {
  const ClassRoutineScreen({Key? key}) : super(key: key);

  @override
  State<ClassRoutineScreen> createState() => _ClassRoutineScreenState();
}

class _ClassRoutineScreenState extends State<ClassRoutineScreen>
    with TickerProviderStateMixin {
  // late TabController _tabController;
  RoutineListController routineListController = RoutineListController();
  final _myBox = Hive.box('eSchoolBox');
  dynamic classname, sectionName;

  @override
  void initState() {
    super.initState();
    classname = _myBox.get('className');
    sectionName = _myBox.get('sectionName');
  }

  @override
  void didChangeDependencies() {
    routineListController = Get.put(RoutineListController());
    routineListController.getRoutineList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoutineListController>(
      init: RoutineListController(),
      builder: (routines) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppDefaultBar(title: "Routine"),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Constants.primaryColor.withOpacity(.5),
                          offset: const Offset(0.00, 5.00))
                    ]),
                child: Center(
                  child: Text(
                    "Class $classname Section $sectionName",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Constants.primaryColor,
                        labelPadding: const EdgeInsets.all(2),
                        indicator: BoxDecoration(
                            border: Border.all(color: Constants.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                            color: Constants.primaryColor),
                        tabs: List.generate(
                          routines.daysList.length,
                          (index) => Tab(
                            child: Text(
                              routines.daysList[index].name.toString(),
                            ),
                          ),
                        ),
                        controller: TabController(
                            initialIndex: 0,
                            length: routines.daysList.length,
                            vsync: this),
                      ),
                    ),
                  ],
                )),
            Flexible(
                child: TabBarView(
              controller: TabController(
                  initialIndex: 0,
                  length: routines.daysList.length,
                  vsync: this),
              children: List.generate(
                routines.daysList.length,
                (index) => const DailyClasses(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class DailyClasses extends StatefulWidget {
  const DailyClasses({Key? key}) : super(key: key);

  @override
  State<DailyClasses> createState() => _DailyClassesState();
}

class _DailyClassesState extends State<DailyClasses> {
  RoutineListController routineListController = RoutineListController();

  final _myBox = Hive.box('eSchoolBox');

  @override
  void didChangeDependencies() {
    routineListController = Get.put(RoutineListController());
    routineListController.getRoutineList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoutineListController>(
      init: RoutineListController(),
      builder: (routines) {
        final routineList = routines.routineList
            .where((routine) =>
                routine.className == _myBox.get('className') &&
                routine.section.toString() == _myBox.get('sectionName'))
            .toList();

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: routineList.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.00),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.whiteGrey),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //const SizedBox(width: 10,),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Constants.primaryColor.withOpacity(.3)),
                          child: const Center(
                            child: Image(
                              image: AssetImage(
                                "assets/subject_icon/bangla.png",
                              ),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const VerticalDivider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${routineList[index].startTime} - ${routineList[index].endTime}",
                              style: const TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${routineList[index].subject}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
