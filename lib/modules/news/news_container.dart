import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news/cubit/news_container_view_model.dart';
import 'package:news_app/modules/news/news_description.dart';
import 'package:news_app/modules/news/news_item.dart';
import '../../api/api_manager.dart';
import '../../models/SourceResponse.dart';
import 'cubit/states.dart';

class NewsContainer extends StatefulWidget {
  final Sources sources;
  NewsContainer({required this.sources});

  @override
  State createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsContainerViewModel viewModel = NewsContainerViewModel();
  ScrollController scrollController = ScrollController();
  int page=1;
  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.sources.id ?? '', page);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NewsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sources.id != widget.sources.id) {
      viewModel.getNewsBySourceId(widget.sources.id ?? '',page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsContainerViewModel, NewsState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage!),
                  ElevatedButton(
                      onPressed: () {
                        ApiManager.getNewsBySourceId(widget.sources.id!,page);
                      },
                      child: Text('Try Again'))
                ],
              ),
            );
          } else if (state is NewsSuccessState) {
            return ListView.builder(
              controller: scrollController,
                itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NewsDescription.routeName,
                    arguments: state.newsList[index],
                  );
                },
                child: NewsItem(news: state.newsList![index]),
              );
            },itemCount: state.newsList.length,);
          } else {
            return Container();
          }
        });
  }
  void addListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      ApiManager.getNewsBySourceId(widget.sources.id!, page+1);
      setState(() {

      });
    }
  }
}





//ChangeNotifierProvider(
//   create: (context) => viewModel,
//   child: Consumer<NewsContainerViewModel>(
//     builder: (context, viewModel, child) {
//       if (viewModel.errorMessage != null) {
//         return Center(child: Text(viewModel.errorMessage!));
//       }
//       if (viewModel.newsList == null) {
//         return Center(child: CircularProgressIndicator());
//       } else {
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   NewsDescription.routeName,
//                   arguments: viewModel.newsList![index],
//                 );
//               },
//               child: NewsItem(news: viewModel.newsList![index]),
//             );
//           },
//           itemCount: viewModel.newsList!.length,
//         );
//       }
//     },
//   ),
// );



// FutureBuilder<NewsResponse?>(
//     future: ApiManager.getNewsBySourceId(widget.sources.id ?? ''),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       if (snapshot.hasError) {
//         return Text('Something went wrong');
//       }
//       if (snapshot.data?.status != 'ok') {
//         return Text(snapshot.data?.message ?? '');
//       }
//       var newsList = snapshot.data?.articles ?? [];
//       return ListView.builder(
//         itemBuilder: (context, index) {
//           return InkWell(onTap: () {
//             Navigator.pushNamed(context, NewsDescription.routeName,
//                 arguments: newsList[index]);
//           }, child: NewsItem(news: newsList[index]));
//         },
//         itemCount: newsList.length,
//       );
//     });
