import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static Color primaryColor=Color(0xFF39A552);
   static ThemeData lightTheme=ThemeData(
     primaryColor: primaryColor,
     scaffoldBackgroundColor: Colors.white,
     appBarTheme: AppBarTheme(
       centerTitle: true,
       toolbarHeight: 70,
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
         fontSize: 22,
         color: Colors.white,
         fontWeight: FontWeight.w400,

       ),
       bodyLarge: GoogleFonts.poppins(
         fontSize: 24,
         color: Colors.black,
         fontWeight: FontWeight.w700,
       ),
       bodyMedium: GoogleFonts.poppins(
         fontSize: 14,
         color: Colors.black,
         fontWeight: FontWeight.w500,
       ),
       bodySmall: GoogleFonts.poppins(
         fontSize: 13,
         color: Colors.black,
         fontWeight: FontWeight.w300,
       ),
     ),
     inputDecorationTheme: InputDecorationTheme(focusedBorder: OutlineInputBorder(borderSide: BorderSide.none))
   );
}