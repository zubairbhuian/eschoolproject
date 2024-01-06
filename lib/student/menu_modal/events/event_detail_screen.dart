import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Widget/app_default_bar.dart';
import '../../utils/constants.dart';

class EventDetailScreen extends StatefulWidget {
  String eventTitle, eventDescription, imagePath;

  EventDetailScreen(
      {Key? key,
      required this.eventTitle,
      required this.eventDescription,
      required this.imagePath})
      : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "Event"),
          Expanded(
              child: Card(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(),
                        Text(
                          widget.eventTitle,
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
                          widget.eventDescription,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
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
