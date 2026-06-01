import 'package:anaytikas_frontend/features/kasir/presentation/pages/keranjang_page.dart';

import '../../../../core/config/theme/app_color.dart';
import '../widgets/product_card_item.dart';
import 'package:flutter/material.dart';

class Homekasir extends StatefulWidget {
  const Homekasir({super.key});

  @override
  State<Homekasir> createState() => _HomekasirState();
}

class _HomekasirState extends State<Homekasir> {
  String? _selectedFilter;
  final List<String> categories = [
    'Alat Mandi',
    'Snack',
    'Alat Tulis',
    'Minuman',
    'Mie Instant',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                Expanded(
                  child: TextField(
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

            Expanded(
              child: ListView.builder(
                itemCount: 6 + 1,
                itemBuilder: (context, index) {
                  // Filter
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownMenu<String>(
                          hintText: 'Pilih Kategori',
                          onSelected: (String? value) {
                            setState(() {
                              _selectedFilter = value;
                            });
                          },
                          dropdownMenuEntries: [
                            const DropdownMenuEntry(value: 'all', label: 'All'),
                            ...categories.map(
                              (item) =>
                                  DropdownMenuEntry(value: item, label: item),
                            ),
                          ],
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
                  }
                  // CardList
                  return ProductCardItem();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
        label: Text(
          '3 Produk',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        extendedPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        backgroundColor: AppColor.primary,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KeranjangPage()),
          );
        },
      ),
    );
  }
}
