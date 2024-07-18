import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import '../category/category_details.dart';
import '../category/category_fragment.dart';
import '../search/search.dart';
import '../settings/settings.dart';
import '../tabs/home_drawer.dart';
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
          backgroundColor: Colors.transparent,
          drawer: Drawer(
            child: HomeDrawer(
              onDrawerClick: onDrawerClick,
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
                    selectedDrawerItem == HomeDrawer.drawerSettingsId
                        ? 'Settings'
                        : selectedCategory == null
                            ? 'News App!'
                            : selectedCategory!.title,
                  style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(onPressed: (){showSearch(context: context, delegate: SearchView());}, icon: Icon(Icons.search))
            ],
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
