import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source_impl.dart';
import 'package:news_app/repository/source/source_repository_contract.dart';

class SourceRepositoryImpl implements SourceRepositoryContract{
  SourceRemoteDataSource sourceRemoteDataSource;

  SourceRepositoryImpl(this.sourceRemoteDataSource);

  @override
  Future<SourceResponse> getSource(String categoryId) {
    return sourceRemoteDataSource.getSource(categoryId);
  }
}
SourceRepositoryContract injectSourceRepositoryContract() {
  return SourceRepositoryImpl(injectSourceRemoteDataSource());
}