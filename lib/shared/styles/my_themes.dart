import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c8_sunday/shared/styles/app_colors.dart';
import 'package:todo_c8_sunday/shared/styles/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.lightGreenColor,
      primaryColor: AppColors.lightColor,
      textTheme: TextTheme(
        bodySmall: AppStyles.Robto12Black(),
        bodyMedium: AppStyles.poppins18Light(),
        bodyLarge: AppStyles.poppins22White(),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightColor,
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          centerTitle: false),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.lightColor,
        unselectedItemColor: Colors.grey.shade500,
      ));
  static ThemeData darkTheme = ThemeData();
}
