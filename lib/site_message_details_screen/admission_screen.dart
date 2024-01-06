import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'details_screen.dart';

class AdmissionDetailScreen extends StatefulWidget {
  const AdmissionDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdmissionDetailScreen> createState() => _AdmissionDetailScreenState();
}

class _AdmissionDetailScreenState extends State<AdmissionDetailScreen> {
  bool isLoading = true;
  dynamic admissionData;

  @override
  void initState() {
    super.initState();
    getAdmissionList();
  }

  Future<void> getAdmissionList() async {
    dynamic admissionList =
        await ApiClient().getData("https://noaparaideal.site/api/admission");
    setState(() {
      isLoading = false;
      admissionData = admissionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: "Admission"),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            admissionData['admission']['fieldName'],
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          HtmlWidget(
                            admissionData['admission']['description']
                                .toString(),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 46,
                              child: OutlinedButton(
                                onPressed: () async {
                                  Get.to(() => DetailsScreen(
                                        pdfLink: admissionData[
                                            'admission_download_file'],
                                        title: 'admission_form',
                                      ));
                                },
                                child: const Text(
                                  'Download  Form',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Constants.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
