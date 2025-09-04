import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';

class BaseApi {
  final http.Client _client = http.Client();

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/${ApiConfig.apiKey}/$endpoint");
    final response = await _client.get(url);

    debugPrint('url:: $url');
    debugPrint('response:: $response');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API error: ${response.statusCode} - ${response.body}");
    }
  }
}
