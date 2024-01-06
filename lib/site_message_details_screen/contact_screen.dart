import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschoolproject/controllers/contact_controller.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/app_default_bar.dart';
import '../student/data/network/constants/endpoints.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactController contactController = ContactController();

  @override
  void didChangeDependencies() {
    contactController = Get.put(ContactController());
    contactController.getContact();
    super.didChangeDependencies();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      init: ContactController(),
      builder: (contact) => Scaffold(
        body: Column(
          children: [
            AppDefaultBar(title: "Contact"),
            Expanded(
                child: contact.loader
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/logo1.png'),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              "Noapara Ideal School",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Location:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Flexible(
                                  child: Text(
                                    contact.location.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Phone:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      _makePhoneCall(contact.phone.toString()),
                                  child: Text(contact.phone.toString()),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mail:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      _sendEmail(contact.mail.toString()),
                                  child: Text(contact.mail.toString()),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Website:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () => launchUrl(
                                      Uri.parse(contact.website.toString())),
                                  child: Text(contact.website.toString()),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
