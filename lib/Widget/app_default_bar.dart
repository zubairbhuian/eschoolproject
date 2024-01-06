import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class AppDefaultBar extends StatelessWidget {
  String title;

  AppDefaultBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0)),
      ),
      backgroundColor: Constants.primaryColor,
      title: Text(
        title,
        style: const TextStyle(
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
    );
  }
}
