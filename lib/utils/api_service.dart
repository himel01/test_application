import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_application_it_grow/utils/urls.dart';

class ApiService {
  http.Client? httClient;

  ApiService({this.httClient}) {
    httClient ??= http.Client();
  }

  Future<http.Response> postRequest(
    String url,
    Map<String, dynamic> body,BuildContext context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      final completeUrl = _buildUrl(url);
      log('API end point $completeUrl');
      final headers = await _getHeaders();
      final encodedBody = json.encode(body);
      return httClient!
          .post(Uri.parse(completeUrl), headers: headers, body: encodedBody);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No Internet")));
      final completeUrl = _buildUrl(url);
      log('API end point $completeUrl');
      final headers = await _getHeaders();
      final encodedBody = json.encode(body);
      return httClient!
          .post(Uri.parse(completeUrl), headers: headers, body: encodedBody);
    }

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
