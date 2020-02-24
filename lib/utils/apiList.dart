class ApiList {
  static getAllSources(String apiKey) {
    return 'http://newsapi.org/v2/sources?apiKey=$apiKey';
  }

  static getLatestNewsBySources(String apiKey, String sourceId) {
    return 'http://newsapi.org/v2/everything?sources=$sourceId&page=1&apiKey=$apiKey';
  }
}
