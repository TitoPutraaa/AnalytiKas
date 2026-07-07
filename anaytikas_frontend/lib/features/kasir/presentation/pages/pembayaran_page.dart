import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';

import '../../../../core/shared/extensions/currency_extension.dart';
import '../../../../core/shared/extensions/datetime_extension.dart';
import '../../../../core/shared/formatter/currency_input_formatter.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_provider.dart';
import '../manager/kasir_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../widgets/detail_transaksi_item.dart';
import '../widgets/total_bayar_item.dart';
import 'nota_page.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _uangPembeliC = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _uangPembeliC.dispose();

    super.dispose();
  }

  Future<void> _onSubmit() async {
    final totalSeluruhHarga = context.read<CartProvider>().totalSeluruhHarga;
    final kasirProvider = context.read<KasirProvider>();
    setState(() => _isLoading = true);

    String cleanValue = _uangPembeliC.text.replaceAll(RegExp(r'[^0-9]'), '');
    double uangMasuk = double.tryParse(cleanValue) ?? 0.0;
    // Validate
    kasirProvider.validateUangPembeli(
      cleanValue,
      totalSeluruhHarga: totalSeluruhHarga,
    );
    if (kasirProvider.errorUangPembeli == null) {
      List<CartItemEntity> cart = context
          .read<CartProvider>()
          .items
          .values
          .toList();

      if (!mounted) return;
      try {
        await kasirProvider.prosesTransaction(cart, uangMasuk);
        final idPenjualan = kasirProvider.idPenjualan;
        if (!context.mounted) return;
        if (idPenjualan != null) {
          if (!mounted) return;
          context.read<CartProvider>().clearCart();
          context.read<StokHomeProvider>().getAllProducts();
          context.read<RiwayatProvider>().loadRiwayat();
          context.read<KasirProvider>().loadProduct();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotaPage(idPenjualan: idPenjualan),
            ),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Gagal memproses transaksi")));
        }
      } finally {
        setState(() => _isLoading = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalSeluruhHarga = context.read<CartProvider>().totalSeluruhHarga;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'TANGGAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGray.withValues(alpha: 0.7),
                    ),
                  ),
                  // Date Today
                  Text(
                    DateTime.now().toFullDate(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGray.withValues(alpha: 0.7),
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Divider(height: 20),

              Text(
                'Detail Transaksi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              // List Product Cart
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  final products = cart.items.values.toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    addRepaintBoundaries: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return DetailTransaksiItem(
                        namaProduct: product.namaProduct,
                        quantity: product.quantity,
                        satuan: product.satuan,
                        totalHarga: product.totalHarga,
                      );
                    },
                  );
                },
              ),

              Divider(height: 40),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    TotalBayarItem(totalSeluruhHarga: totalSeluruhHarga),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGray.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          'Cash',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGray.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 230),
            ],
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Masukkan uang pembeli dibawah.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.darkGray.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _uangPembeliC,
                onChanged: (value) {
                  context.read<KasirProvider>().validateUangPembeli(value);
                },

                keyboardType: TextInputType.number,
                inputFormatters: [CurrencyInputFormatter()],
                decoration: InputDecoration(
                  labelText: 'Uang Pembeli',
                  labelStyle: TextStyle(fontSize: 14, color: AppColor.darkGray),
                  prefixText: 'Rp  ',
                  prefixStyle: TextStyle(),
                  hintText: '0',
                  hintStyle: TextStyle(fontSize: 14, color: AppColor.lowGray),
                  errorText: context.select<KasirProvider, String?>(
                    (p) => p.errorUangPembeli,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.lowGray),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL BELANJA ',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.darkGray.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    totalSeluruhHarga.toRupiah(),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                // height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment_rounded),
                            SizedBox(width: 15),
                            Text(
                              'Bayar Sekarang',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
