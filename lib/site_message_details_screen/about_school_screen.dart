import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutSchoolScreen extends StatefulWidget {
  final dynamic aboutSchoolData;
  AboutSchoolScreen({Key? key, required this.aboutSchoolData})
      : super(key: key);

  @override
  State<AboutSchoolScreen> createState() => _AboutSchoolScreenState();
}

class _AboutSchoolScreenState extends State<AboutSchoolScreen> {
  dynamic aboutSchoolData;

  @override
  void initState() {
    super.initState();
    aboutSchoolData = widget.aboutSchoolData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "About School"),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                      height: 300,
                      width: double.maxFinite,
                      child: CachedNetworkImage(
                        imageUrl: Endpoints.baseImageUrl +
                            aboutSchoolData["image"].toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: AppIndecator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  HtmlWidget(
                    aboutSchoolData["description"].toString(),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
