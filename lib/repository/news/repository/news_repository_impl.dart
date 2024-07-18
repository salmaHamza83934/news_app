import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/repository/news/data_source/news_remote_data_source_impl.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl(this.newsRemoteDataSource);

  @override
  Future<NewsResponse> getNewsByCategoryId({required String sourceId,int page=1}) {
    return newsRemoteDataSource.getNewsByCategoryId(sourceId: sourceId,page: page);
  }
}
NewsRepositoryContract injectNewsRepositoryContract(){
  return NewsRepositoryImpl(injectNewsRemoteDataSource());
}
