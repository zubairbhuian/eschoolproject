// ignore_for_file: file_names, depend_on_referenced_packages
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailsScreen extends StatefulWidget {
  final String pdfLink;
  final String title;

  const DetailsScreen({Key? key, required this.pdfLink, required this.title})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Constants.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await saveFile(widget.pdfLink, widget.title + '.pdf');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'File Downloaded successfully!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.download,
              ),
            ),
          )
        ], //Actions
      ),
      body: Container(
          color: Constants.primaryColor,
          child: SfPdfViewer.network(
            widget.pdfLink,
            key: _pdfViewerKey,
          )),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          String newPath = directory.path + '/Download';
          directory = Directory(newPath);

          File saveFile = File("${directory.path}/$fileName");

          if (kDebugMode) {
            print(saveFile.path);
          }

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          if (await directory.exists()) {
            await Dio().download(
              url,
              saveFile.path,
            );
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
