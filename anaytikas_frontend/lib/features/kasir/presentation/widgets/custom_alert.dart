import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  const CustomAlert({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        children: [
          Icon(Icons.inventory_2_outlined, color: AppColor.primary, size: 50),
          Text(
            title,
            style: TextStyle(
              color: AppColor.primary,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      content: Text(content),
      actions: [
        ElevatedButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Oke',
            style: TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
