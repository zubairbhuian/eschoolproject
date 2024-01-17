import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class AppDefaultBar extends StatelessWidget {
 final String title;

 const AppDefaultBar({
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



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar(
      {super.key,
      this.title,
    });

// Specify the desired height of the AppBar
  @override
  Size get preferredSize => Size.fromHeight(66.0);

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
        title??"",
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
