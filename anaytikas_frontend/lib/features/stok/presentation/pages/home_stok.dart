import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/barang_baru.dart';
import 'package:anaytikas_frontend/features/stok/presentation/pages/ops_stok.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/produk_stok_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homestok extends StatefulWidget {
  const Homestok({super.key});

  @override
  State<Homestok> createState() => _HomestokState();
}

class _HomestokState extends State<Homestok> {
  final ScrollController _scrollController = ScrollController();
  bool _showSearchBar = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;
    final scrollingDown = currentOffset > _lastOffset;

    // ignore tiny jitters (e.g. iOS bounce) — only react past a small threshold
    if ((currentOffset - _lastOffset).abs() < 4) return;

    if (scrollingDown && _showSearchBar) {
      setState(() => _showSearchBar = false);
    } else if (!scrollingDown && !_showSearchBar) {
      setState(() => _showSearchBar = true);
    }

    _lastOffset = currentOffset;
  }

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
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BarangBaru(),
                      ),
                    );
                    if (result == true && context.mounted) {
                      context.read<StokHomeProvider>().getAllProducts();
                    }
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
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                ),
              ),
            ],
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _showSearchBar
                ? TextField(
                    onChanged: (value) {
                      context.read<StokHomeProvider>().searchProduct(value);
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
                      hintText: 'Cari nama produk...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColor.lowGray,
                      ),
                    ),
                    onTapOutside: (PointerDownEvent click) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),

          Consumer<StokHomeProvider>(
            builder: (context, stok, child) {
              if (stok.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (stok.allProducts.isEmpty) {
                return Center(
                  child: Text(
                    stok.isSearching
                        ? "Produk tidak ditemukan"
                        : "Produk anda masih kosong, silakan menambahakan produk baru",
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  controller:
                      _scrollController, // ← must attach here, this is the list actually scrolling
                  itemCount: stok.allProducts.length,
                  itemBuilder: (context, index) {
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
