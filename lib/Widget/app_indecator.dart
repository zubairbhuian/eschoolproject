import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppIndecator extends StatelessWidget {
  final double? size;
  final Color? color;
  const AppIndecator({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: size ?? 30,
      color: color ?? Constants.primaryColor,
    );
  }
}

class LoadIndecator extends StatelessWidget {
  final Color? color;
  final double? size;
  const LoadIndecator({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      //FadingCircle
      size: size ?? 20,
      color: color ?? Colors.white,
    );
  }
}
