import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingItemDetailScreen extends StatefulWidget {
 final String settingItemName;
 final String settingItemLink;

 const SettingItemDetailScreen({
    required this.settingItemName,
    required this.settingItemLink,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingItemDetailScreen> createState() =>
      _SettingItemDetailScreenState();
}

class _SettingItemDetailScreenState extends State<SettingItemDetailScreen> {
  late WebViewController _controller;

  @override
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.settingItemLink),
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDefaultBar(title: widget.settingItemName),
          Expanded(
            child: WebViewWidget(
              controller: _controller,

            ),
          )
        ]
      ),
    );
  }
}
