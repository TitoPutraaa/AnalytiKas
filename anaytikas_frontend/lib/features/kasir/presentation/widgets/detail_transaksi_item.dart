import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class DetailTransaksiItem extends StatelessWidget {
  const DetailTransaksiItem({super.key});

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
              'Kopi Arabica 250g',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGray.withValues(alpha: 0.8),
              ),
            ),
            Text(
              '10 pcs',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGray.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Text(
          'Rp. 90.000',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.darkGray.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
