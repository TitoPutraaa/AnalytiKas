import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/shared/widgets/main_sheel.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.mainTheme,

      home: MainSheel(),
    );
  }
}
