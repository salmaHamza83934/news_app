import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/NewsResponse.dart';

class NewsItem extends StatelessWidget {

  News news;

  NewsItem({required this.news});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage??'',
              placeholder: (context, url) => Center(child: CircularProgressIndicator(
                color: theme.primaryColor,
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 15.h,),
          Text(news.author??'',style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 13.sp,fontWeight: FontWeight.w700),),
          SizedBox(height: 10.h,),
          Text(news.title??'',style: theme.textTheme.bodyMedium,),
          Text(news.publishedAt??'',style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),textAlign: TextAlign.end,),
        ],
      ),
    );
  }
}
