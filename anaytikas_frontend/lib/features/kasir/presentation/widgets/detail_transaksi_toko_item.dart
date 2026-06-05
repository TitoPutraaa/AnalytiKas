import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class DetailTransaksiTokoItem extends StatelessWidget {
  const DetailTransaksiTokoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Toko',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.darkGray.withValues(alpha: 0.7),
                ),
              ),
              Text(
                'Toko Suka Suka',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.darkGray.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat Toko',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.darkGray.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  textAlign: TextAlign.right,
                  'Jl. Kampung Durian Runtuh',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGray.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
