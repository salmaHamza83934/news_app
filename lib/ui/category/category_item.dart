import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/category.dart';

class CategoryItem extends StatelessWidget {

  Category category;
  int index;

  CategoryItem({required this.category,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(index%2==0?20.r:0),
          bottomLeft: Radius.circular(index%2==0?0:20.r),
      ),
      ),
      child: Column(
        children: [
          Image.asset(category.imageUrl,height: MediaQuery.sizeOf(context).height*0.15,),
          Text(category.title,style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
