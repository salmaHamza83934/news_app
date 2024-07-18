import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/repository/source/repository/source_repository_impl.dart';

import '../tabs/tab_container.dart';
import 'cubit/category_details_view_model.dart';
import 'cubit/states.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_screen';
  Category category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel=CategoryDetailsViewModel(injectSourceRepositoryContract());

  void initState(){
    super.initState();
    viewModel.getSourceByCategoryId(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<CategoryDetailsViewModel,SourceState>(
     bloc: viewModel,
     builder: (context,state){
       if(state is SourceLoadingState){
         return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),);
       }else if(state is SourceErrorState){
         return Center(
           child: Column(
             children: [
               Text(state.errorMessage!),
               ElevatedButton(onPressed:(){viewModel.getSourceByCategoryId(widget.category.id);}, child: Text('Try Again'))
             ],
           ),
         );
       }else if(state is SourceSuccessState){
         return TabContainer(sourcesList: state.sourceList);
       }
       else{
         return Container();
       }
     }
     );
  }
}