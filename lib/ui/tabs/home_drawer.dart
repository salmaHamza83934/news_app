import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends StatelessWidget {
  static const int drawerCategoryId=1;
  static const int drawerSettingsId=2;
  Function onDrawerClick;

  HomeDrawer({required this.onDrawerClick});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(40.r),
          height: mediaQuery.height*0.2,
          width: mediaQuery.width,
          color: theme.primaryColor,
          child: Center(child: Text('News App!',style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white))),
        ),
        InkWell(
          onTap: (){
            onDrawerClick(HomeDrawer.drawerCategoryId);
          },
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              children: [
                Icon(Icons.list,size: 40,),
                SizedBox(width: 20.w),
                Text('Categories',style: theme.textTheme.bodyLarge,)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            onDrawerClick(HomeDrawer.drawerSettingsId);
          },
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              children: [
                Icon(Icons.settings,size: 40,),
                SizedBox(width: 20.w,),
                Text('Settings',style: theme.textTheme.bodyLarge,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
