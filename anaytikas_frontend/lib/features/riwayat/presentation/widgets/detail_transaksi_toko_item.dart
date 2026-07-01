import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class DetailTransaksiTokoItem extends StatelessWidget {
  final String namaToko;
  final String alamat;
  const DetailTransaksiTokoItem({
    super.key,
    required this.namaToko,
    required this.alamat,
  });

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
                namaToko,
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
                  alamat,
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
