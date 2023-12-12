import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news/cubit/states.dart';
import '../../../api/api_manager.dart';

class NewsContainerViewModel extends Cubit<NewsState> {
  NewsContainerViewModel() : super(NewsLoadingState());

  void getNewsBySourceId(String sourceId, int? page) async {
    try {
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsBySourceId(sourceId: sourceId);
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




// class NewsContainerViewModel extends ChangeNotifier{
//   List<News>? newsList;
//   String? errorMessage;
//
//   Future<void> getNewsBySourceId(String sourceId)async{
//      newsList=[];
//      errorMessage=null;
//      notifyListeners();
//     try {
//       var response = await ApiManager.getNewsBySourceId(sourceId);
//       if (response.status == 'error') {
//         errorMessage = response.message;
//       }
//       else {
//         newsList = response.articles;
//       }
//     }catch(e){
//       errorMessage=='Error loading source list';
//     }
//     notifyListeners();
//   }
// }
