import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/menu_modal/notice/notice_details_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool isLoading = false;

  dynamic noticeList;

  @override
  void initState() {
    super.initState();
    getNotice();
  }

  Future<dynamic> getNotice() async {
    isLoading = true;
    noticeList = await ApiClient().getData(Endpoints.noticeList);

    // dev.log(noticeList.toString());

    // print(noticeList['data']);
    if (noticeList == false) {
      isLoading = true;
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppDefaultBar(title: "Notice Board"),
        isLoading == true
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                          noticeDate: noticeData[index]['date']
                                              .toString(),
                                        )));
                          },
                          child: Card(
                              color:Constants.whiteGrey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            //snapshot.data![index].title!.toString(),
                                            noticeData[index]['title'].toString(),
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
                                            noticeData[index]['date'].toString(),
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
                                    const Icon(Icons.arrow_forward_ios, color: Constants.primaryColor,)
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              )
      ],
    ));
  }
}
