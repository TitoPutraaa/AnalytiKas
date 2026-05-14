import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final mainTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Rubik',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarThemeData(backgroundColor: Colors.red),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
        // buat nama produk
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ), // buat nama barang
      labelSmall: TextStyle(fontSize: 8, fontWeight: FontWeight.w200),
    ),
  );
}
