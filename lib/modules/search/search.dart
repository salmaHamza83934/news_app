import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_theme.dart';

import '../../api/api_manager.dart';
import '../../models/NewsResponse.dart';
import '../news/news_description.dart';
import '../news/news_item.dart';

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: ()=>showResults(context), icon:Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder<NewsResponse?>(
        future: ApiManager.getSearch(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.data?.status != 'ok') {
            return Text(snapshot.data?.message ?? '');
          }
          var newsList = snapshot.data?.articles ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index]);
            },
            itemCount: newsList.length,
          );
        });
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return AppTheme.lightTheme;
  }
}
