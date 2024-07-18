import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static Color primaryColor=Color(0xFF39A552);
   static ThemeData lightTheme=ThemeData(
     primaryColor: primaryColor,
     scaffoldBackgroundColor: Colors.white,
     appBarTheme: AppBarTheme(
       titleTextStyle: GoogleFonts.exo(
         fontSize: 22.sp,
         color: Colors.white,
         fontWeight: FontWeight.w400,

       ),
       iconTheme: IconThemeData(color: Colors.white),
       centerTitle: true,
       toolbarHeight: 70.h,
       color: primaryColor,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
           bottomLeft: Radius.circular(35),
           bottomRight: Radius.circular(35)
         ),
       )
     ),
     textTheme: TextTheme(
       titleLarge: GoogleFonts.exo(
         fontSize: 22.sp,
         color: Colors.white,
         fontWeight: FontWeight.w400,

       ),
       bodyLarge: GoogleFonts.poppins(
         fontSize: 24.sp,
         color: Colors.black,
         fontWeight: FontWeight.w700,
       ),
       bodyMedium: GoogleFonts.poppins(
         fontSize: 14.sp,
         color: Colors.black,
         fontWeight: FontWeight.w500,
       ),
       bodySmall: GoogleFonts.poppins(
         fontSize: 13.sp,
         color: Colors.black,
         fontWeight: FontWeight.w300,
       ),
     ),
     inputDecorationTheme: InputDecorationTheme(focusedBorder: OutlineInputBorder(borderSide: BorderSide.none))
   );
}