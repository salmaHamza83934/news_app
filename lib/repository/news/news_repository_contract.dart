import 'package:news_app/models/NewsResponse.dart';

import '../../models/SourceResponse.dart';

abstract class NewsRepositoryContract{
  Future<NewsResponse> getNewsByCategoryId({required String sourceId,int page=1});
}
abstract class NewsRemoteDataSource{
  Future<NewsResponse> getNewsByCategoryId({required String sourceId,int page=1});
}