import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/ui/home_layout/home_screen.dart';
import 'package:news_app/ui/news/news_description.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(412,870),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:AppTheme.lightTheme,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName:(context)=>HomeScreen(),
          NewsDescription.routeName:(context)=>NewsDescription(),
        },
      );}
    );
  }
}
