import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/shared/extensions/datetime_extension.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/pages/homeRiwayat.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/detail_transaksi_item.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/detail_transaksi_toko_item.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/total_bayar_item.dart';
import 'package:flutter/material.dart';

class DetailRiwayatPenjualanPage extends StatelessWidget {
  final RiwayatPenjualan penjualan;
  const DetailRiwayatPenjualanPage({super.key, required this.penjualan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          'Rincian Transaksi',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 40,
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                const Text(
                  'TRANSAKSI BERHASIL',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Terima kasih atas kunjungan Anda',
                  style: TextStyle(color: AppColor.darkGray),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TANGGAL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  'ID TRANSAKSI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tanggal
                Text(
                  DateTime.parse(penjualan.tanggal).toFullDate(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.9),
                  ),
                ),
                // Id Penjualan
                Text(
                  '${penjualan.idPenjualan}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),
            const SizedBox(height: 10),
            TotalBayarItem(totalSeluruhHarga: penjualan.totalHarga),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Uang Diterima',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkGray.withValues(alpha: 0.9),
                        ),
                      ),
                      // Text(
                      //   context.read<KasirProvider>().uangMasuk.toRupiah(),
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColor.darkGray.withValues(alpha: 0.9),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kembalian',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkGray.withValues(alpha: 0.9),
                        ),
                      ),
                      // Text(
                      //   context
                      //       .read<KasirProvider>()
                      //       .uangKembali
                      //       .toRupiah(),
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColor.darkGray.withValues(alpha: 0.9),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: AppColor.darkGray.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: Text(
                'Detail Transaksi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 15),
            DetailTransaksiTokoItem(
              namaToko: penjualan.namaToko,
              alamat: penjualan.alamat,
            ),

            Divider(height: 45),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: penjualan.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final products = penjualan.items[index];
                return DetailTransaksiItem(
                  namaProduct: products.namaProduct,
                  quantity: products.jumlah,
                  satuan: products.satuan,
                  totalHarga: products.totalHargaPerProduct,
                );
              },
            ),

            const SizedBox(height: 120),
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
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
                Text('Kembali', style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
