import 'package:flutter/material.dart';
import 'package:news_app/modules/category/category_item.dart';

import '../../models/category.dart';

class CategoryFragment extends StatelessWidget {
  static String routeName='category_fragment';
  var categoryList = Category.getCategory();
  Function onCategoryClick;

  CategoryFragment({required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick your category \n of interest',
            style:
                theme.textTheme.bodyLarge!.copyWith(color: Color(0xFF4F5A69)),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    onCategoryClick(categoryList[index]);
                  },
                    child: CategoryItem(
                        category: categoryList[index], index: index));
              },
              itemCount: categoryList.length,
            ),
          )
        ],
      ),
    );
  }
}
