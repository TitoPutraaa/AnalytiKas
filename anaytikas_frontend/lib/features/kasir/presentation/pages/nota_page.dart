import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';
import '../../../../shared/widgets/main_sheel.dart';
import '../widgets/detail_transaksi_item.dart';
import '../widgets/detail_transaksi_toko_item.dart';
import '../widgets/total_bayar_item.dart';

class NotaPage extends StatelessWidget {
  const NotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          'Pembayaran Berhasil',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
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
                    fontSize: 16,
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
                Text(
                  '24 Oct 2023',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  'AB123XXX1',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),
            const SizedBox(height: 10),
            TotalBayarItem(),
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
                      Text(
                        'Rp 350.000',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkGray.withValues(alpha: 0.9),
                        ),
                      ),
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
                      Text(
                        'Rp 34.000',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkGray.withValues(alpha: 0.9),
                        ),
                      ),
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
            DetailTransaksiTokoItem(),

            Divider(height: 45),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return DetailTransaksiItem();
              },
            ),

            const SizedBox(height: 80),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainSheel()),
              );
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
                Text(
                  'Kembali ke Beranda',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
