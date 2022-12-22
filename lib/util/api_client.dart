import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../resource/app_constant.dart';

class ApiClient {
  Future<Response> postData(
    String endpoint,
    String path,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    final String url = Uri.parse(urlOpenAI).toString();
    final Uri uri = Uri.https(endpoint, path);
    final Object bodyRequest = json.encode(body);
    try {
      final Response response = await post(
        uri,
        headers: headers,
        body: bodyRequest,
      ).timeout(const Duration(seconds: 30));

      return response;
    } on SocketException catch (e) {
      throw Exception(e);
    } on TimeoutException catch (e) {
      throw Exception(e);
    }
  }
}
