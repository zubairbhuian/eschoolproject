import 'dart:convert';

import 'package:eschoolproject/student/data/network/apis/server.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/data/network/models/contact_model.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  Server server = Server();
  bool loader = false;
  dynamic location, phone, mail, website;

  getContact() async {
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });

    server.getRequest(endPoint: Endpoints.contactList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        var contactData = ContactModel.fromJson(jsonResponse);

        location = contactData.data!.address;
        phone = contactData.data!.phone;
        mail = contactData.data!.email;
        website = contactData.data!.website;

        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Something went wrong');
      }
    });
  }
}
