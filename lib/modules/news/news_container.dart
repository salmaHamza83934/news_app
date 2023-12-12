import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news/cubit/news_container_view_model.dart';
import 'package:news_app/modules/news/news_description.dart';
import 'package:news_app/modules/news/news_item.dart';
import '../../api/api_manager.dart';
import '../../models/NewsResponse.dart';
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
  int page = 1;
  List<News> news = [];
  bool shouldLoadNextPage = false;

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.sources.id ?? '', page);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        shouldLoadNextPage = true;
        setState(() {});
      }
    });
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
      viewModel.getNewsBySourceId(widget.sources.id ?? '', page);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shouldLoadNextPage) {
      ApiManager.getNewsBySourceId(sourceId: widget.sources.id!, page: ++page)
          .then((NewsResponse) => news.addAll(NewsResponse.articles ?? []));
      shouldLoadNextPage = false;
      setState(() {});
    }
    return BlocBuilder<NewsContainerViewModel, NewsState>(
        bloc: viewModel,
        builder: (context, state) {
           if (state is NewsErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage!),
                  ElevatedButton(
                      onPressed: () {
                        ApiManager.getNewsBySourceId(
                            sourceId: widget.sources.id!);
                      },
                      child: Text('Try Again'))
                ],
              ),
            );
          }
           else if (state is NewsSuccessState) {
            if (news.isEmpty) {
              news = state.newsList;
            }else if(news.first.title != state.newsList.first.title){
              news=state.newsList;
              scrollController.jumpTo(0);
            }
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
              },
              itemCount: state.newsList.length,
            );
          }
           else {
             return Center(
               child: CircularProgressIndicator(
                 color: Theme.of(context).primaryColor,
               ),
             );
           }
        });
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
