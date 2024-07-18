import '../../models/SourceResponse.dart';

abstract class SourceRepositoryContract{
  Future<SourceResponse> getSource(String categoryId);
}
abstract class SourceRemoteDataSource{
  Future<SourceResponse> getSource(String categoryId);
}