import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/source/source_repository_contract.dart';

import '../news_repository_contract.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource{
  ApiManager apiManager;

  NewsRemoteDataSourceImpl(this.apiManager);

  @override
  Future<NewsResponse> getNewsByCategoryId({required String sourceId,int page=1})async {
    return await apiManager.getNewsBySourceId(sourceId: sourceId,page: page);
  }
}
NewsRemoteDataSource injectNewsRemoteDataSource(){
  return NewsRemoteDataSourceImpl(ApiManager.getInstance());

}