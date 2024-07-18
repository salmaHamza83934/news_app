import 'package:news_app/api/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source_impl.dart';
import 'package:news_app/repository/source/repository/source_repository_impl.dart';
import 'package:news_app/repository/source/source_repository_contract.dart';
import 'package:news_app/ui/category/cubit/states.dart';

class CategoryDetailsViewModel extends Cubit<SourceState>{
  SourceRepositoryContract sourceRepositoryContract;
  CategoryDetailsViewModel(this.sourceRepositoryContract):super(SourceLoadingState());

  void getSourceByCategoryId(String categoryId)async{
   try{
     emit(SourceLoadingState());
     var response= await sourceRepositoryContract.getSource(categoryId);
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