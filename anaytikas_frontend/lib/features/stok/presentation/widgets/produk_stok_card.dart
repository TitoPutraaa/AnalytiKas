import 'package:anaytikas_frontend/core/shared/extensions/currency_extension.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/edit_produk.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/tambah_stok.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:provider/provider.dart';

class ProductStockCard extends StatelessWidget {
  final ProductEntity product;

  const ProductStockCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isLowStock = product.jmlhStok <= product.stokWarning;

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
                        product.namaProduct,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Kode Barang: ${product.idProduct}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Kategori: ${product.kategori.namaKategori}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Rp ${product.harga.hargaJual.toThoushandsSeparator()}",
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
                        "${product.jmlhStok}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isLowStock
                              ? Colors.red
                              : Colors.green.shade700,
                        ),
                      ),

                      Text(
                        "${product.harga.satuan}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProduk(product: product),
                        ),
                      );
                      if (result == true && context.mounted) {
                        context.read<StokHomeProvider>().getAllProducts();
                      }
                    },
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
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Tambahstok(product: product),
                        ),
                      );
                      if (result == true && context.mounted) {
                        context.read<StokHomeProvider>().getAllProducts();
                      }
                    },
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
