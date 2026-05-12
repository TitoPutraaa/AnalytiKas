import 'package:anaytikas_frontend/presentation/widgets/navbar.dart';
import 'package:anaytikas_frontend/presentation/widgets/topBar.dart';
import 'package:flutter/material.dart';

class Homestok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar.topBar,
      body: Center(child: Text("Halo World", style: TextStyle(fontSize: 40))),
      bottomNavigationBar: Navbar(),
    );
  }
}
