import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';

class TransactionCard extends StatelessWidget {
  final String tanggal;
  final String waktu;
  final List<TransactionItem> items;
  final double totalHarga;
  final VoidCallback? onTap;

  const TransactionCard({
    Key? key,
    required this.tanggal,
    required this.waktu,
    required this.items,
    required this.totalHarga,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = items.length > 1 ? items.length - 1 : 0;
    final firstItem = items.isNotEmpty ? items[0] : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Stack(
            children: [
              Container(
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
                    // first item bar
                    if (firstItem != null)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEEF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      firstItem.namaProduct,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColor.darkGray,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Jumlah: ${firstItem.jumlah}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.lowGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Rp ${firstItem.harga.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // remaining count
                    if (remaining > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          '+ $remaining item lainnya..',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.lowGray,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              // TOTAL badge top-right
              Positioned(
                right: 18,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xffE6EEF8)),
                  ),
                  child: const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColor.lowGray,
                      fontWeight: FontWeight.w600,
                    ),
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
