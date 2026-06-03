import 'package:flutter/material.dart';

class OpsStok extends StatefulWidget {
  const OpsStok({super.key});

  @override
  State<OpsStok> createState() => _OpsStokState();
}

class _OpsStokState extends State<OpsStok> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Operasional Stok")),
    );
  }
}
