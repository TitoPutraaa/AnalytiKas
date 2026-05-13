import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/analisis/presentation/pages/homeAnalisis.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/pages/homeKasir.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/pages/homeRiwayat.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/homeStok.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class MainSheel extends StatefulWidget {
  @Preview(name: "mainsheel")
  const MainSheel({super.key});

  @override
  State<MainSheel> createState() => _MainSheelState();
}

class _MainSheelState extends State<MainSheel> {
  int _currentPageIndex = 0;

  final List<Widget> _screen = [
    Homekasir(),
    Homeriwayat(),
    Homestok(),
    Homeanalisis(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnalytiKas"),
        titleTextStyle: TextStyle(
          color: AppColor.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: "Rubik",
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: IndexedStack(index: _currentPageIndex, children: _screen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.lowGray,
        onTap: (index) => setState(() => _currentPageIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale),
            label: "Kasir",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: "History",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Stok"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analisis",
          ),
        ],
      ),
    );
  }
}
