import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class Topbar {
  static final topBar = AppBar(
    title: Text("AnalytiKas"),
    titleTextStyle: TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    centerTitle: true,

    backgroundColor: AppColor.primary,
  );
}
