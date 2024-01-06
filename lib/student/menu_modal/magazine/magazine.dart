import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/menu_modal/magazine/magazine_detail_screen.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({Key? key}) : super(key: key);

  @override
  State<MagazineScreen> createState() => _MagazineScreenState();
}

class _MagazineScreenState extends State<MagazineScreen> {
  bool isLoading = false;

  dynamic magazineList;

  @override
  void initState() {
    super.initState();
    getMagazine();
  }

  Future<dynamic> getMagazine() async {
    isLoading = true;
    magazineList = await ApiClient().getData(Endpoints.magazineList);
    if (magazineList == false) {
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
          AppDefaultBar(title: "Magazine"),
          const SizedBox(
            height: 8,
          ),
          isLoading == true
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: magazineList["data"].length,
                      itemBuilder: (context, int index) {
                        var magazineData = magazineList["data"];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MagazineDetailScreen(
                                          megazineTitle: magazineData[index]
                                                  ["title"]
                                              .toString(),
                                          megazineDescription:
                                              magazineData[index]["description"]
                                                  .toString(),
                                          imagePath: magazineData[index]
                                                  ["image"]
                                              .toString(),
                                        ))));
                          },
                          child: Card(
                              color: Constants.whiteGrey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Constants.shadowColor,
                                          child: ClipOval(
                                            child: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: CachedNetworkImage(
                                                imageUrl: magazineData[index]
                                                        ["image_url"]
                                                    .toString(),
                                                //   fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error, color: Constants.primaryColor,),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          magazineData[index]["title"]
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.primaryColor,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios, color: Constants.primaryColor,)
                                  ],
                                ),
                              )),
                        );
                      }),
                )
        ],
      ),
    );
  }
}
