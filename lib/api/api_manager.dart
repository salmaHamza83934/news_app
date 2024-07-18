import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/api/api_constants.dart';

class ApiManager {

  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance(){
    _instance??=ApiManager._();
    return _instance!;
  }

   Future<SourceResponse> getSource(String categoryId) async {
    /*
   https://newsapi.org/v2/top-headlines/sources?apiKey=d791296979b843a68ad75b2d5a73e86c
  */
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourceApi,
        {'apiKey': 'd791296979b843a68ad75b2d5a73e86c', 'category': categoryId,
        //'language':'en'
        });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

   Future<NewsResponse> getNewsBySourceId(
      {required String sourceId, int page = 1}) async {
    /*
    https://newsapi.org/v2/everything?q=bitcoin&apiKey=d791296979b843a68ad75b2d5a73e86c
    */
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': 'd791296979b843a68ad75b2d5a73e86c',
      'sources': sourceId,
      'pageSize': '20',
      'page': '$page',
      //'language':'en'
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getSearch(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi,
        {'apiKey': 'd791296979b843a68ad75b2d5a73e86c', 'q': query});
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
