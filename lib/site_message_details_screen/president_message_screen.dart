import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../Widget/app_default_bar.dart';
import '../student/data/network/constants/endpoints.dart';

class PresidentMessageScreen extends StatefulWidget {
  dynamic presidentMessageData;
 PresidentMessageScreen({Key? key,required this.presidentMessageData}) : super(key: key);

  @override
  State<PresidentMessageScreen> createState() => _PresidentMessageScreenState();
}

class _PresidentMessageScreenState extends State<PresidentMessageScreen> {
  dynamic presidentMessageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presidentMessageData = widget.presidentMessageData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "President Message"),
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
                            imageUrl: Endpoints.baseImageUrl+presidentMessageData["image"].toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          )
                        ),
                        const Divider(),
                        HtmlWidget(
                          presidentMessageData["description"]
                              .toString(),
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
