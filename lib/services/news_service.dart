import 'dart:convert';

import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/utils/api_endpoint.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:http/http.dart' as http;

List<NewsModel> parseData(responseBody) {
  final parsed = json.decode(responseBody)['articles'];
  return parsed.map<NewsModel>((json) => NewsModel.fromJson(json)).toList();
}

Future<List<NewsModel>> getTopHeadlineNews(String countryId) async {
  final response = await http.get(ApiEndpoint.topHeadlineNews(Constant.apiKey, countryId));
  final int statusCode = response.statusCode;

  if (statusCode == 200) {
    return parseData(response.body);
  } else {
    throw Exception('Failed to load event');
  }
}
