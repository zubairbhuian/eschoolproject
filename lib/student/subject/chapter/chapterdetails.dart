import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/subject/chapter/diaries_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class ChapterDetails extends StatefulWidget {
 final String chapterTitle;
 final dynamic diaryData;
 const ChapterDetails({required this.chapterTitle, required this.diaryData, Key? key}) : super(key: key);

  @override
  State<ChapterDetails> createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails>
    with TickerProviderStateMixin {
  double screenWidth = 0;
  double screenHeight = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: widget.chapterTitle),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                        color: Constants.primaryColor ,
                        borderRadius: BorderRadius.circular(8)),
                    tabs: const [
                      Tab(child: Text("Diaries", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                      Tab(
                          child: Text(
                        "Files",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                      Tab(
                          child: Text(
                        "Videos",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
          Flexible(
              child: TabBarView(
                  controller: _tabController,
                  children: [DiariesScreen(diaryData: widget.diaryData), const Files(), const Videos()]))
        ],
      ),
    );
  }
}


class Files extends StatefulWidget {
  const Files({Key? key}) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child:Center(child: Text("No files uploaded yet")),
    );
  }
}

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Center(child: Text("No videos uploaded yet")) );
  }
}
