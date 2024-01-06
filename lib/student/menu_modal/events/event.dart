import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/menu_modal/events/event_detail_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../Widget/app_default_bar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isLoading = false;

  dynamic eventList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geteventList();
  }

  Future<dynamic> geteventList() async {
    isLoading = true;
    eventList = await ApiClient().getData(Endpoints.eventList);
    if (eventList == false) {
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
          AppDefaultBar(title: "Events"),
          const SizedBox(
            height: 8,
          ),
          isLoading == true
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: eventList["data"].length,
                        itemBuilder: (context, int index) {
                          var eventData = eventList["data"];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventDetailScreen(
                                          eventTitle: eventData[index]["title"]
                                              .toString(),
                                          eventDescription: eventData[index]
                                                  ["description"]
                                              .toString(),
                                          imagePath: eventData[index]
                                                  ["image_url"]
                                              .toString())));
                            },
                            child: Card(
                                color: Constants.whiteGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Constants.shadowColor,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: CachedNetworkImage(
                                              imageUrl: eventData[index]
                                                      ["image_url"]
                                                  .toString(),
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 16,
                                      // ),
                                      const VerticalDivider(),
                                      Expanded(
                                        child: Text(
                                          eventData[index]["title"].toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.primaryColor,
                                              fontSize: 18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Constants.primaryColor,
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                )
        ],
      ),
    );
  }
}
