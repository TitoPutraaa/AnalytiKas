import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';

class ProductStockCard extends StatelessWidget {
  final String namaBarang;
  final String kodeBarang;
  final int jumlahStok;
  final int minStok;
  final double hargaJual;
  final String kategori;

  const ProductStockCard({
    super.key,
    required this.namaBarang,
    required this.kodeBarang,
    required this.jumlahStok,
    required this.minStok,
    required this.hargaJual,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    bool isLowStock = jumlahStok <= minStok;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      color: AppColor.white,
      shadowColor: AppColor.darkGray,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColor.lowGray, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaBarang,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Kode Barang: $kodeBarang",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Kategori: $kategori",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Rp ${hargaJual.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Stok produk
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "STOK",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "$jumlahStok",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isLowStock
                              ? Colors.red
                              : Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 15,
              color: AppColor.lowGray,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),

            // ---Manage Produk Button
            Row(
              spacing: 5,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: AppColor.black, width: 1),
                      ),
                      fixedSize: Size.fromHeight(2),
                    ),
                    label: Text(
                      "Edit stok",
                      style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    icon: Icon(Icons.settings, color: AppColor.black),
                  ),
                ),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text(
                      "Stok",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    icon: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      fixedSize: Size.fromHeight(2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
