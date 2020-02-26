import 'dart:convert';

import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/models/source_news_model.dart';
import 'package:flutter_news/utils/api_endpoint.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:http/http.dart' as http;

List<SourceNewsModel> parseData(responseBody) {
  final parsed = json.decode(responseBody)['sources'];
  return parsed.map<SourceNewsModel>((json) => SourceNewsModel.fromJson(json)).toList();
}

List<NewsModel> parseDataDetailSourceNews(responseBody) {
  final parsed = json.decode(responseBody)['articles'];
  return parsed.map<NewsModel>((json) => NewsModel.fromJson(json)).toList();
}

Future<List<SourceNewsModel>> getSourceNews() async {
  final response = await http.get(ApiEndpoint.getAllSources(Constant.apiKey));
  final int statusCode = response.statusCode;

  if (statusCode == 200) {
    return parseData(response.body);
  } else {
    throw Exception('Failed to load event');
  }
}

Future<List<NewsModel>> getDetailSourceNews(String sourceId) async {
  final response = await http.get(ApiEndpoint.detailSourceNews(Constant.apiKey, sourceId));
  final int statusCode = response.statusCode;

  if (statusCode == 200) {
    return parseDataDetailSourceNews(response.body);
  } else {
    throw Exception('Failed to load event');
  }
}