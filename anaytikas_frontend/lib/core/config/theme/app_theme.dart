import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final mainTheme = ThemeData(
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1A237E), fill: 1.0),
  );

  static final textTheme = TextTheme(
    // bisa di sesuain aja gais
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ), // buat header fiutre ex: kasir, stok
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ), // buat nama barang
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ), // deskripsi
  );
}
