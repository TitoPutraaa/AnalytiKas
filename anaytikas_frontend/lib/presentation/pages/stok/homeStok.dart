import 'package:anaytikas_frontend/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';

class Homestok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnalitiKas")),
      body: Text("hais"),
      bottomNavigationBar: Navbar(),
    );
  }
}
