import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../manager/cart_provider.dart';
import '../manager/kasir_provider.dart';
import '../widgets/product_card_item.dart';
import 'keranjang_page.dart';

class Homekasir extends StatelessWidget {
  const Homekasir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        context.read<KasirProvider>().resetSearch();
                      } else {
                        context.read<KasirProvider>().filterProducts(
                          query: value,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColor.lowGray),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColor.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search, size: 20),
                      hintText: 'Cari nama produk atau SKU...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColor.lowGray,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Scan
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.lowGray),
                    padding: EdgeInsets.zero,
                    fixedSize: const Size(10, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.document_scanner_rounded, size: 25),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Filter
            Consumer<KasirProvider>(
              builder: (context, kasir, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu(
                      width: 200,
                      hintText: 'Pilih Kategori',
                      onSelected: (value) {
                        if (value != null) {
                          if (value == 0) {
                            kasir.resetSearch();
                          } else {
                            kasir.filterProducts(categoryId: value);
                          }
                        }
                      },
                      dropdownMenuEntries: kasir.allCategory
                          .map(
                            (item) => DropdownMenuEntry(
                              value: item.idKategori,
                              label: item.namaKategori,
                            ),
                          )
                          .toList(),
                      textStyle: TextStyle(fontSize: 14),
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
            Consumer<KasirProvider>(
              builder: (context, kasir, child) {
                if (kasir.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (kasir.allProducts.isEmpty) {
                  return Center(
                    child: Text(
                      kasir.isSearching
                          ? 'Produk tidak ditemukan.'
                          : 'Produk anda masih kosong.',
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: kasir.allProducts.length,
                    itemBuilder: (context, index) {
                      final product = kasir.allProducts[index];
                      // CardList
                      return ProductCardItem(product: product);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cart, child) => cart.items.isEmpty
            ? SizedBox()
            : FloatingActionButton.extended(
                icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
                label: Text(
                  '${cart.items.length} Produk',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                extendedPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                backgroundColor: AppColor.primary,

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KeranjangPage()),
                  );
                },
              ),
      ),
    );
  }
}
