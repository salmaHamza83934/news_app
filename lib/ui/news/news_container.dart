import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import '../../api/api_manager.dart';
import '../../models/NewsResponse.dart';
import '../../models/SourceResponse.dart';
import 'cubit/news_container_view_model.dart';
import 'cubit/states.dart';
import 'news_description.dart';
import 'news_item.dart';

class NewsContainer extends StatefulWidget {
  final Sources sources;

  NewsContainer({required this.sources});

  @override
  State createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsContainerViewModel viewModel = NewsContainerViewModel(injectNewsRepositoryContract());
  ScrollController scrollController = ScrollController();
  int page = 1;
  List<News> news = [];
  bool shouldLoadNextPage = false;
  ApiManager apiManager = ApiManager.getInstance();

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(sourceId: widget.sources.id ?? '', page: page);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop && !shouldLoadNextPage) {
          setState(() {
            shouldLoadNextPage = true;
          });
        }
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
      page = 1;
      news.clear();
      viewModel.getNewsBySourceId(sourceId: widget.sources.id ?? '', page: page);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shouldLoadNextPage) {
      apiManager
          .getNewsBySourceId(sourceId: widget.sources.id!, page: ++page)
          .then((newsResponse) {
        setState(() {
          news.addAll(newsResponse.articles ?? []);
          shouldLoadNextPage = false;
        });
      });
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
                    viewModel.getNewsBySourceId(sourceId: widget.sources.id!, page: page);
                  },
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is NewsSuccessState) {
          if (news.isEmpty) {
            news = state.newsList;
          } else if (news.first.title != state.newsList.first.title) {
            news = state.newsList;
            if (scrollController.hasClients) {
              scrollController.jumpTo(0);
            }
          }
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
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
                      child: NewsItem(news: state.newsList[index]),
                    );
                  },
                  itemCount: state.newsList.length,
                ),
              ),
              if (shouldLoadNextPage)
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
