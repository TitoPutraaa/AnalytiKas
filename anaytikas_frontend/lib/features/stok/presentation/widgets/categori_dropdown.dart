import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class CategoriDropdown extends StatelessWidget {
  final String? selectedItem;
  final List<String> categories;
  final ValueChanged onChanged;
  final String hintTxt;
  final IconData icon;
  const CategoriDropdown({
    super.key,
    required this.selectedItem,
    required this.categories,
    required this.onChanged,
    required this.hintTxt,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.darkGray),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedItem,
          isExpanded: true,
          hint: Row(
            children: [
              Icon(icon, color: AppColor.lowGray, size: 18),
              SizedBox(width: 8),
              Text(
                hintTxt,
                style: TextStyle(color: AppColor.lowGray, fontSize: 14),
              ),
            ],
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColor.lowGray,
            size: 20,
          ),
          dropdownColor: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          items: categories
              .map(
                (c) => DropdownMenuItem(
                  value: c,
                  child: Text(
                    c,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
