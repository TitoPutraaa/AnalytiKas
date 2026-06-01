import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class TotalBayarItem extends StatelessWidget {
  const TotalBayarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: AppColor.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Total Bayar',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            'Rp. 316.000',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
