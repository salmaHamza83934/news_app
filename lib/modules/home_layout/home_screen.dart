import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/modules/category/category_fragment.dart';
import 'package:news_app/modules/category/category_details.dart';
import 'package:news_app/modules/search/search_view.dart';
import 'package:news_app/modules/settings/settings.dart';
import 'package:news_app/modules/tabs/home_drawer.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
          drawer: Drawer(
            child: HomeDrawer(
              onDrawerClick: onDrawerClick,
            ),
          ),
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){Navigator.pushNamed(context, SearchView.routeName);}, icon: Icon(Icons.search))
            ],
            title: Text(
                    selectedDrawerItem == HomeDrawer.drawerSettingsId
                        ? 'Settings'
                        : selectedCategory == null
                            ? 'News App!'
                            : selectedCategory!.title,
                  ),
          ),
          body: selectedDrawerItem == HomeDrawer.drawerSettingsId
              ? Settings()
              : selectedCategory == null
                  ? CategoryFragment(
                      onCategoryClick: onCategoryClick,
                    )
                  : CategoryDetails(category: selectedCategory!),
        ),
      ],
    );
  }

  Category? selectedCategory;

  void onCategoryClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  int selectedDrawerItem = HomeDrawer.drawerCategoryId;

  void onDrawerClick(int newSelectedDrawerItem) {
    selectedDrawerItem = newSelectedDrawerItem;
    selectedCategory = null;
    setState(() {});
    Navigator.pop(context);
  }
}
