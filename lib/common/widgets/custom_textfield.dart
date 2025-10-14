import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Widget? sufIcon;
  final Widget? preIcon;
  final ValueChanged<String>? onChange;
  final double borderRadius;
  final Color? containerColor;
  final Color? borderColor;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.height = 48,
    this.controller,
    this.hintText,
    this.hintTextStyle,
    this.sufIcon,
    this.preIcon,
    this.onChange,
    this.borderRadius = 8,
    this.containerColor,
    this.borderColor,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    Widget? buildPrefix() {
      if (preIcon == null) return null;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            preIcon!,
            sw8,
            Container(
              width: 2,
              height: 22,
              color: borderColor ?? AppColors.borderColor,
            ),
            sw8,
          ],
        ),
      );
    }
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? AppColors.borderColor),
        color: containerColor,
      ),
      child: TextField(
        textInputAction: TextInputAction.done,
        onChanged: onChange,
        controller: controller,
        maxLines: obscureText ? 1 : null,
        keyboardType: obscureText ? TextInputType.text : (keyboardType ?? TextInputType.multiline),
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: hintTextStyle ?? h5.copyWith(color: AppColors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: buildPrefix(),
          suffixIcon: sufIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}