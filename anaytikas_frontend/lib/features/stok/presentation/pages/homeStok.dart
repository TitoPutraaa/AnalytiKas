import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
// import 'package:anaytikas_frontend/features/stok/presentation/widgets/produkStokCard.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/produk_stok_card.dart';
import 'package:flutter/material.dart';

class Homestok extends StatelessWidget {
  const Homestok({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
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
                      label: const Text(
                        "Barang Baru",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      label: const Text(
                        "Operasional",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: ProductStockCard(
              namaBarang: "Kopi Arabica 250g",
              kodeBarang: '12fds13',
              jumlahStok: 12,
              minStok: 10,
              hargaJual: 10000,
              Kategori: "Minuman",
            ),
          ),
        ],
      ),
    );
  }
}
