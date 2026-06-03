import 'package:flutter/material.dart';

class EditStok extends StatefulWidget {
  const EditStok({super.key});

  @override
  State<EditStok> createState() => _EditStokState();
}

class _EditStokState extends State<EditStok> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Edit Stok")),
    );
  }
}
