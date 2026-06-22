import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/barang_baru.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/ops_stok.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/produk_stok_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homestok extends StatelessWidget {
  Product? product;

  Homestok({super.key, Product? product}) : product = product ?? Product.dummy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BarangBaru(),
                      ),
                    );
                  },
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const OpsStok()),
                    );
                  },
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

          Consumer<StokHomeProvider>(
            builder: (context, stok, child) {
              if (stok.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (stok.allCategory.isEmpty) {
                return Center(
                  child: Text(
                    "Produk anda masih kosong, silakan menambahakan produk baru",
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: 5 + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColor.lowGray,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColor.primary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.search, size: 20),
                          hintText: 'Cari nama produk atau SKU...',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.lowGray,
                          ),
                        ),
                        onTapOutside: (PointerDownEvent click) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      );
                    }
                    return ProductStockCard(product: stok.allProducts[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
