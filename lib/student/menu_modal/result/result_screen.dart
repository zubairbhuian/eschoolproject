import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/mixins.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0)),
        ),
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "Result",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Constants.primaryColor),
              ),
              onPressed: () {
                _launchInWebView( //https://www.nisraozan.com/internal_result
                    Uri.parse('https://www.nisraozan.com/internal_result'));
              },
              child: const Text(
                "See Result",
                style: TextStyle(color: Constants.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
