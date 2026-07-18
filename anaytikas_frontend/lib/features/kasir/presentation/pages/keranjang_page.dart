import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../../../../core/shared/extensions/currency_extension.dart';
import '../manager/cart_provider.dart';
import '../widgets/cart_card_item.dart';
import '../widgets/custom_alert.dart';
import 'pembayaran_page.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Saya',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Porduk yang terpilih'),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lowGray.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Builder(
                    builder: (context) {
                      final length = context.select<CartProvider, int>(
                        (c) => c.items.length,
                      );
                      return Text('$length unit');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Consumer<CartProvider>(
              builder: (context, cart, child) {
                final listProduct = cart.items.values.toList();
                if (cart.items.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            'Keranjang anda kosong. ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: listProduct.length,
                    itemBuilder: (context, index) {
                      final product = listProduct[index];
                      return CartCardItem(cart: product);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.lowGray.withValues(alpha: 0.1),
                blurRadius: 2,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL BELANJA ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final totalSeluruhHarga = context
                          .select<CartProvider, double>(
                            (c) => c.totalSeluruhHarga,
                          );
                      return Text(
                        totalSeluruhHarga.toRupiah(),
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final product = context.read<CartProvider>().items;

                  if (product.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PembayaranPage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlert(
                        title: 'Keranjang Kosong',
                        content:
                            'Maaf keranjang anda kosong. Harap pilih produk terlebih dahulu',
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_rounded),
                    SizedBox(width: 15),
                    Text(
                      'Buat Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
