import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/SourceResponse.dart';

class TabItem extends StatelessWidget {
  bool isSelected;
  Sources source;

  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: theme.primaryColor, width: 3),
          color: isSelected ? theme.primaryColor : Colors.transparent),
      child: Text(
        source.name ?? '',
        style: theme.textTheme.bodyMedium!
            .copyWith(color: isSelected ? Colors.white : theme.primaryColor),
      ),
    );
  }
}
