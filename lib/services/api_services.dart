import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_news/services/app_strings.dart';

class ApiServices {
  fetchFeeds() async {
    Uri url = Uri.parse(AppStrings.baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint("response is : ${jsonDecode(response.body)}");
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load feeds");
    }
  }
}
