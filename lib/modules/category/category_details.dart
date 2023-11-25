import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/modules/category/cubit/category_details_view_model.dart';
import 'package:news_app/modules/category/cubit/states.dart';
import 'package:news_app/modules/tabs/tab_container.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_screen';
  Category category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel=CategoryDetailsViewModel();

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
               ElevatedButton(onPressed:(){ ApiManager.getSource(widget.category.id);}, child: Text('Try Again'))
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







//ChangeNotifierProvider(
//   create: (context)=>viewModel,
//   child: Stack(
//     children: [
//       Container(
//           color: Colors.white,
//           width: double.infinity,
//           height: double.infinity,
//           child: Image.asset('assets/images/pattern.png')),
//       Consumer<CategoryDetailsViewModel>(builder:(context,viewModel,child){
//         if(viewModel.errorMessage!=null){
//           return Center(child: Text(viewModel.errorMessage!));
//         }
//         if(viewModel.sourceList==null){
//           return Center(child: CircularProgressIndicator());
//         }else{
//           return TabContainer(sourcesList: viewModel.sourceList!);
//         }
//       } )
//
//     ],
//   ),
// );



// FutureBuilder<SourceResponse?>(
//   future: ApiManager.getSource(widget.category.id),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasError) {
//       return Column(
//         children: [
//           Text(
//             'something went wrong',
//             style: theme.textTheme.bodyLarge!
//                 .copyWith(color: theme.primaryColor),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 ApiManager.getSource(widget.category.id);
//               },
//               child: Text('Try again?'))
//         ],
//       );
//     }
//     if (snapshot.data?.status != 'ok') {
//       return Column(
//         children: [
//           Text(
//             snapshot.data?.message ?? '',
//             style: theme.textTheme.titleLarge!
//                 .copyWith(color: theme.primaryColor),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 ApiManager.getSource(widget.category.id);
//               },
//               child: Text('Try again?'))
//         ],
//       );
//     }
//     var sourcesList = snapshot.data?.sources ?? [];
//     return TabContainer(
//       sourcesList: sourcesList,
//     );
//   },
// ),