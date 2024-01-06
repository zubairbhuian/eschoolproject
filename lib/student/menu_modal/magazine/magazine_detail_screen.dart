import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class MagazineDetailScreen extends StatefulWidget {
  String megazineTitle, megazineDescription, imagePath;
  MagazineDetailScreen(
      {Key? key,
      required this.megazineTitle,
      required this.megazineDescription,
      required this.imagePath})
      : super(key: key);

  @override
  State<MagazineDetailScreen> createState() => _MagazineDetailScreenState();
}

class _MagazineDetailScreenState extends State<MagazineDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "Magazine"),
          Expanded(
              child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(),
                    Text(
                      widget.megazineTitle,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor),
                    ),
                    const Divider(),
                    Container(
                      height: 120,
                      width: double.maxFinite,
                      color: Constants.shadowColor,
                      child: CachedNetworkImage(
                        imageUrl: widget.imagePath,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Constants.primaryColor,),
                      ),

                    ),
                    const Divider(),
                    Text(
                      widget.megazineDescription,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16,),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
