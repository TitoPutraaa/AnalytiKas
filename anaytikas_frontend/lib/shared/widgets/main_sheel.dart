import 'package:anaytikas_frontend/features/auth/presentation/pages/profile_page.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/home_stok.dart';

import '../../core/config/theme/app_color.dart';
import '../../features/analisis/presentation/pages/home_analisis.dart';
import '../../features/kasir/presentation/pages/home_kasir.dart';
import '../../features/riwayat/presentation/pages/homeRiwayat.dart';
import 'package:flutter/material.dart';

class MainSheel extends StatefulWidget {
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

  String headerTitle() {
    if (_currentPageIndex == 0) {
      return "KASIR";
    } else if (_currentPageIndex == 1) {
      return "RIWAYAT TRANSAKSI";
    } else if (_currentPageIndex == 2) {
      return "STOK";
    } else {
      return "ANALISIS";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
              },
              icon: Icon(Icons.storefront_outlined, size: 30),
            ),
          ),
        ],
        title: Text(headerTitle()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          color: AppColor.primary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: "Rubik",
        ),
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
