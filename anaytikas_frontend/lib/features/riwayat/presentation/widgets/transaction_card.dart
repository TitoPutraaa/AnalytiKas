import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';

class TransactionCard extends StatelessWidget {
  final String tanggal;
  final String waktu;
  final List<TransactionItem> items;
  final double totalHarga;

  const TransactionCard({
    Key? key,
    required this.tanggal,
    required this.waktu,
    required this.items,
    required this.totalHarga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan tanggal dan waktu
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal & waktu',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.lowGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$tanggal, $waktu',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.darkGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.lowGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.darkGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xffE0E0E0)),
          // List item produk
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.namaProduct,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.darkGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jumlah: ${item.jumlah}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.lowGray,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rp ${item.harga.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem {
  final String namaProduct;
  final int jumlah;
  final double harga;

  TransactionItem({
    required this.namaProduct,
    required this.jumlah,
    required this.harga,
  });
}
