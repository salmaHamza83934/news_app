import 'package:flutter/material.dart';
import 'package:news_app/models/NewsResponse.dart';
import '../../api/api_manager.dart';
import '../news/news_description.dart';
import '../news/news_item.dart';

class SearchView extends StatefulWidget {
  static const String routeName = 'search_view';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Image.asset('assets/images/pattern.png'),
        ),
        Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.search),
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    ApiManager.getSearch(value);
                    searchController.text = value;
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<NewsResponse?>(
                    future: ApiManager.getSearch(searchController.text),
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
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, NewsDescription.routeName,
                                    arguments: newsList[index]);
                              },
                              child: NewsItem(news: newsList[index]));
                        },
                        itemCount: newsList.length,
                      );
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
