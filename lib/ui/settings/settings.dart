import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding:EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Language',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
          SizedBox(height: 10.h,),
          Container(
            margin: EdgeInsets.all(5.r),
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: theme.primaryColor)),
            child: Text(
              'English',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }



}
