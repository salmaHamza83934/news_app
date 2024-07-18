import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDescription extends StatelessWidget {
  static String routeName = 'news_description';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)?.settings.arguments as News;
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
          appBar: AppBar(
            title: Text(args.title ?? ''),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: mediaQuery.height * 0.02,
                    bottom: mediaQuery.height * 0.01),
                child: CachedNetworkImage(
                  imageUrl: args.urlToImage ?? '',
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      args.source?.name ?? '',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      args.title ?? '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      args.publishedAt ?? '',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                    Container(
                      width: mediaQuery.width * 0.75,
                      height: mediaQuery.height * 0.30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              args.description ?? '',
                              style: theme.textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 15,
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL(args.url ?? '');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('View full article'),
                                  Icon(Icons.play_arrow_rounded)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _launchURL(String newsUrl) async {
    var url = Uri.parse(newsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $newsUrl';
    }
  }
}
