import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/presentation/pages/stok/homeStok.dart';
import 'package:anaytikas_frontend/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),

        textTheme: AppTheme.textTheme,
      ),
      home: Homestok(),

      debugShowCheckedModeBanner: false,
    );
  }
}
