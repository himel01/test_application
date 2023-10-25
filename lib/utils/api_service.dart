import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:test_application_it_grow/utils/urls.dart';

class ApiService {
  http.Client? httClient;

  ApiService({this.httClient}) {
    httClient ??= http.Client();
  }

  Future<http.Response> postRequest(
    String url,
    Map<String, dynamic> body, {
    Duration? timeout,
    bool checkAccessValidity = true,
  }) async {
    final completeUrl = _buildUrl(url);
    log('API end point $completeUrl');
    final headers = await _getHeaders();
    final encodedBody = json.encode(body);
    return httClient!
        .post(Uri.parse(completeUrl), headers: headers, body: encodedBody);
  }

  Future<Map<String, String>> _getHeaders() async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return headers;
  }

  String _buildUrl(String partialUrl) {
    final baseUrl = Urls.baseUrl;
    return baseUrl + partialUrl;
  }
}
