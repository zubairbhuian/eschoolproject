import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../Widget/app_default_bar.dart';
import '../student/data/network/constants/endpoints.dart';

class HeadmasterMessageScreen extends StatefulWidget {
final  dynamic headmasterMessageData;
   HeadmasterMessageScreen({Key? key,required this.headmasterMessageData}) : super(key: key);

  @override
  State<HeadmasterMessageScreen> createState() =>
      _HeadmasterMessageScreenState();
}

class _HeadmasterMessageScreenState extends State<HeadmasterMessageScreen> {
  dynamic headmasterMessageData;


  @override
  void initState() {  
    super.initState();
    headmasterMessageData=widget.headmasterMessageData;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "HeadMaster Message"),
         Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.maxFinite,
                          child: CachedNetworkImage(
                            imageUrl:Endpoints.baseImageUrl+ headmasterMessageData["image"].toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: AppIndecator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          )
                        ),
                        const Divider(),
                        HtmlWidget(
                          headmasterMessageData["description"]
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
