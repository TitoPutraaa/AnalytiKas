import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/barang_baru.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/opsStok.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/produk_stok_card.dart';
import 'package:flutter/material.dart';

class Homestok extends StatelessWidget {
  Product? product;

  Homestok({super.key, Product? product}) : product = product ?? Product.dummy;

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
                          MaterialPageRoute(
                            builder: (context) => const OpsStok(),
                          ),
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
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return ProductStockCard(
                  product: product!,
                  key: ValueKey(product!.idProduct),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
