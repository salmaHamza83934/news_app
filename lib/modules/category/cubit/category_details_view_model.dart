import 'package:news_app/api/api_manager.dart';
import 'package:news_app/modules/category/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsViewModel extends Cubit<SourceState>{
  CategoryDetailsViewModel():super(SourceLoadingState());

  void getSourceByCategoryId(String categoryId)async{
   try{
     emit(SourceLoadingState());
     var response= await ApiManager.getSource(categoryId);
     if(response.status=='error'){
       emit(SourceErrorState(errorMessage:response.message));
     }
     else{
       emit(SourceSuccessState(sourceList: response.sources!));
     }
   }catch(e){
     emit(SourceErrorState(errorMessage: 'Error loading Source List'));
   }
  }
}















// class CategoryDetailsViewModel extends ChangeNotifier{
//   List<Sources>? sourceList;
//   String? errorMessage;
//   void getSourceByCategoryId(String categoryId)async{
//     try{
//       var response=await ApiManager.getSource(categoryId);
//       if(response.status=='error'){
//         errorMessage=response.message;
//       }
//       else{
//         sourceList=response.sources;
//       }
//     }catch(e){
//       errorMessage=='Error loading source list';
//     }
//     notifyListeners();
//   }
// }