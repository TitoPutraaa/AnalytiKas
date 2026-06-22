import 'package:anaytikas_frontend/core/shared/entities/kategori_entity.dart';
import 'package:anaytikas_frontend/core/shared/entities/product_with_details_entity.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/pages/camera_scanner_page.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/widgets/hardware_scanner_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../manager/cart_provider.dart';
import '../manager/kasir_provider.dart';
import '../widgets/product_card_item.dart';
import 'keranjang_page.dart';

class Homekasir extends StatelessWidget {
  const Homekasir({super.key});

  void _onBarcodeScanned(BuildContext context, String code) {
    final product = context.read<KasirProvider>().findProductByBarcode(code);
    if (product != null) {
      context.read<CartProvider>().addItemToCart(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produk dengan barcode "$code" tidak ditemukan'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HardwareScannerListener(
      onScan: (code) => _onBarcodeScanned(context, code),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    onPressed: () async {
                      final code = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CameraScannerPage(),
                        ),
                      );
                      if (code != null && context.mounted) {
                        _onBarcodeScanned(context, code);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter
              Builder(
                builder: (context) {
                  final category = context
                      .select<KasirProvider, List<KategoriEntity>>(
                        (k) => k.allCategory,
                      );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownMenu(
                        width: 200,
                        hintText: 'Pilih Kategori',
                        onSelected: (value) {
                          if (value != null) {
                            final kasir = context.read<KasirProvider>();
                            if (value == 0) {
                              kasir.resetSearch();
                            } else {
                              kasir.filterProducts(categoryId: value);
                            }
                          }
                        },
                        dropdownMenuEntries: category
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
              Builder(
                builder: (context) {
                  final state = context
                      .select<
                        KasirProvider,
                        (bool, bool, List<ProductWithDetailsEntity>)
                      >((k) => (k.isLoading, k.isSearching, k.allProducts));
                  final (isLoading, isSearching, allProducts) = state;
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (allProducts.isEmpty) {
                    return Center(
                      child: Text(
                        isSearching
                            ? 'Produk tidak ditemukan.'
                            : 'Produk anda masih kosong.',
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: allProducts.length,
                      itemBuilder: (context, index) {
                        final product = allProducts[index];
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
        floatingActionButton: Builder(
          builder: (context) {
            final cartLength = context.select<CartProvider, int>(
              (c) => c.items.length,
            );
            if (cartLength == 0) {
              return SizedBox();
            } else {
              return FloatingActionButton.extended(
                icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
                label: Text(
                  '$cartLength Produk',
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
              );
            }
          },
        ),
      ),
    );
  }
}
