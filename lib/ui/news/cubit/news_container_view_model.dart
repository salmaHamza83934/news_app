import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/repository/news/data_source/news_remote_data_source_impl.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/ui/news/cubit/states.dart';
import '../../../api/api_manager.dart';

class NewsContainerViewModel extends Cubit<NewsState> {
  NewsRepositoryContract newsRepositoryContract;
  NewsContainerViewModel(this.newsRepositoryContract) : super(NewsLoadingState());


  void getNewsBySourceId({required String sourceId, int page=1}) async {
    try {
      emit(NewsLoadingState());
      var response = await newsRepositoryContract.getNewsByCategoryId(sourceId: sourceId,page: page);
      if (response.status == 'error') {
        emit(NewsErrorState(errorMessage: response.message));
      } else {
        emit(NewsSuccessState(newsList: response.articles!));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: 'Error loading News List'));
    }
  }
}
