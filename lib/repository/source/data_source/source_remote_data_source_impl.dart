import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/source/source_repository_contract.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSource{
  ApiManager apiManager;

  SourceRemoteDataSourceImpl(this.apiManager);

  @override
  Future<SourceResponse> getSource(String categoryId)async {
    return await apiManager.getSource(categoryId);
  }
}
SourceRemoteDataSource injectSourceRemoteDataSource(){
  return SourceRemoteDataSourceImpl(ApiManager.getInstance());
}