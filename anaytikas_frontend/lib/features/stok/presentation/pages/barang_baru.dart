import 'package:flutter/material.dart';

class BarangBaru extends StatefulWidget {
  const BarangBaru({super.key});

  @override
  State<BarangBaru> createState() => _BarangBaruState();
}

class _BarangBaruState extends State<BarangBaru> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text("barang baru"));
  }
}
