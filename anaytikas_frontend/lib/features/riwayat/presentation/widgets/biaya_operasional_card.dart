import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/shared/extensions/currency_extension.dart';
import 'package:anaytikas_frontend/core/shared/extensions/datetime_extension.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/pages/detail_riwayat_biaya_operasional_page.dart';
import 'package:flutter/material.dart';

class BiayaOperasionalCard extends StatelessWidget {
  final RiwayatOperasional data;
  const BiayaOperasionalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailRiwayatBiayaOperasionalPage(biayaOperasional: data),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 14, top: 17),
              child: const Text(
                'Biaya Operasional',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            // ── Row atas: tanggal | TOTAL + nominal ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime.parse(data.tanggal).toFullDate(),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '- ${data.totalBiaya.toRupiah()}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            // ── Row bawah: nama item + harga ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.namaBiaya,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                    ],
                  ),
                  Text(
                    data.totalBiaya.toRupiah(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),

            // ── "+ 1 item lainnya.." ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              //
            ),
          ],
        ),
      ),
    );
  }
}
