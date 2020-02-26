import 'package:flutter_news/utils/constant.dart';

class ApiEndpoint {
  static getAllSources(String apiKey) {
    return '${Constant.baseUrl}/sources?apiKey=$apiKey';
  }

  static detailSourceNews(String apiKey, String sourceId) {
    return '${Constant.baseUrl}/everything?sources=$sourceId&page=1&apiKey=$apiKey';
  }

  static topHeadlineNews(String apiKey, String  country) {
    return '${Constant.baseUrl}/top-headlines?country=$country&apiKey=$apiKey';
  }
}
