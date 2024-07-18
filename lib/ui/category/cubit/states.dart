import '../../../models/SourceResponse.dart';

abstract class SourceState{}
class SourceLoadingState extends SourceState{}
class SourceErrorState extends SourceState{
  String? errorMessage;

  SourceErrorState({required this.errorMessage});
}
class SourceSuccessState extends SourceState{
  List<Sources> sourceList;
  SourceSuccessState({required this.sourceList});
}

