import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';
import '../../../../core/shared/extensions/currency_extension.dart';

class DetailTransaksiItem extends StatelessWidget {
  final String namaProduct;
  final int quantity;
  final String satuan;
  final double totalHarga;

  const DetailTransaksiItem({
    super.key,
    required this.namaProduct,
    required this.quantity,
    required this.satuan,
    required this.totalHarga,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaProduct,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.darkGray.withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$quantity $satuan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGray.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Text(
          totalHarga.toRupiah(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.darkGray.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
