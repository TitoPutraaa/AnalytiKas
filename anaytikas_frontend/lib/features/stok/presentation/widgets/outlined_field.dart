import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextAlign textAlign;

  const OutlinedField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.prefixIcon,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.darkGray),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textAlign: textAlign,
        style: const TextStyle(
          fontSize: 14,
          color: AppColor.primary,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColor.lowGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          prefix: prefix,
          contentPadding: prefixIcon != null || prefix != null
              ? const EdgeInsets.symmetric(vertical: 14)
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          isDense: true,
        ),
      ),
    );
  }
}
