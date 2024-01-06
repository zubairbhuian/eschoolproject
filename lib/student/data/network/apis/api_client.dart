import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../exceptions/network_exceptions.dart';

class ApiClient {
  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> getData(String url) async {
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      dynamic jsonList = jsonDecode(jsonDataString);
      return jsonList;
    } else {
      return false;
    }
  }

  Future<dynamic> postData(String url) async {
    var request = http.Request('POST', Uri.parse(url));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      String jsonDataString = await response.stream.bytesToString();
      dynamic jsonList = jsonDecode(jsonDataString);
      return jsonList;
    } else {
      //  print(response.reasonPhrase);
      return false;
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path) {
    return http.get(Uri.https(Endpoints.baseUrl, path)).then(createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .post(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(createResponse);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .put(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(createResponse);
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .delete(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic createResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw NetworkException(
          message: 'Error fetching data from server', statusCode: statusCode);
    }

    return _decoder.convert(res);
  }
}
