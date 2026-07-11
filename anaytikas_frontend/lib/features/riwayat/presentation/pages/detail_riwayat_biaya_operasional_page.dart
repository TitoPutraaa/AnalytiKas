import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/shared/extensions/currency_extension.dart';
import 'package:anaytikas_frontend/core/shared/extensions/datetime_extension.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';

import 'package:flutter/material.dart';

class DetailRiwayatBiayaOperasionalPage extends StatelessWidget {
  final RiwayatOperasional biayaOperasional;
  const DetailRiwayatBiayaOperasionalPage({
    super.key,
    required this.biayaOperasional,
  });

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
            const SizedBox(height: 70),
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
                Row(
                  children: [
                    Text(
                      DateTime.parse(biayaOperasional.tanggal).toFullDate(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DatetimeExtension.parseToShortTime(
                        biayaOperasional.waktu,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                // Id Biaya Operasional
                Text(
                  '${biayaOperasional.idBiaya}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Detail Transaksi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      biayaOperasional.namaBiaya,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                Text(
                  biayaOperasional.totalBiaya.toRupiah(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  biayaOperasional.totalBiaya.toRupiah(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: AppColor.primary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'Cash',
                        style: TextStyle(
                          fontSize: 15,
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
            Divider(height: 0),

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
