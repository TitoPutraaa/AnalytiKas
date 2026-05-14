import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/widgets/produkStok.dart';
import 'package:flutter/material.dart';

class Homestok extends StatelessWidget {
  const Homestok({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        spacing: 10,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Barang Baru"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Operasional"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: ProdukStok()),
        ],
      ),
    );
  }
}
