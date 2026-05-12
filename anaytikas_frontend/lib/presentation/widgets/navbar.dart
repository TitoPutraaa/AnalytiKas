import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/presentation/pages/stok/homeStok.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class Navbar extends StatefulWidget {
  @Preview(name: "Navbar", brightness: Brightness.light)
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int curentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (index) {
        setState(() {
          curentPage = index;
          if (index == 0) {
            Homestok();
          }
        });
      },
      indicatorColor: AppColor.gray,
      backgroundColor: Colors.white70,
      selectedIndex: curentPage,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.point_of_sale_outlined, color: AppColor.gray),
          selectedIcon: Icon(Icons.point_of_sale, color: AppColor.primary),
          label: 'Kasir',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_edu, color: AppColor.gray),
          selectedIcon: Icon(
            Icons.history_edu_outlined,
            color: AppColor.primary,
          ),
          label: 'Riwayat',
        ),
        NavigationDestination(
          icon: Icon(Icons.inventory, color: AppColor.gray),
          selectedIcon: Icon(
            Icons.inventory_2_outlined,
            color: AppColor.primary,
          ),
          label: 'Stok',
        ),
        NavigationDestination(
          icon: Icon(Icons.analytics_outlined, color: AppColor.gray),
          selectedIcon: Icon(Icons.analytics_rounded, color: AppColor.primary),
          label: 'Kasir',
        ),
      ],
      // body: <Widget>[Homestok(), Text("data")],
    );
  }
}
