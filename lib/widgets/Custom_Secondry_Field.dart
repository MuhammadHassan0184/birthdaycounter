// ignore_for_file: library_private_types_in_public_api, file_names, must_be_immutable, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSecondryField extends StatefulWidget {
  final String label;
  final IconData? icon; // optional
  final String? prefixImage; // optional SVG image path
  final IconData? suicon; // suffix icon (like password toggle)
  final VoidCallback? onTap;
  final String? Function(String?)? validation;
  final TextEditingController? controller;

  CustomSecondryField({
    super.key,
    required this.label,
    this.icon,
    this.prefixImage,
    this.suicon,
    this.onTap,
    this.validation,
    this.controller, required Function(dynamic val) onChanged,
  }) : assert(
         icon != null || prefixImage != null,
         'Either icon or prefixImage must be provided',
       );

  @override
  _CustomSecondryFieldState createState() => _CustomSecondryFieldState();
}

class _CustomSecondryFieldState extends State<CustomSecondryField> {
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validation,
      obscureText: widget.suicon != null ? !showpass : false,
      textAlignVertical: TextAlignVertical.center,
      onTap: widget.onTap,
      decoration: InputDecoration(
        prefixIcon: widget.prefixImage != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  widget.prefixImage!,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : Icon(widget.icon, color: AppColors.primary, size: 20),
        suffixIcon: widget.suicon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showpass = !showpass;
                  });
                },
                icon: Icon(
                  showpass ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grey,
                  size: 20,
                ),
              )
            : null,
        hintText: widget.label,
        hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.2),
            width: 0.9,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.2),
            width: 0.9,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.25),
            width: 0.6,
          ),
        ),
      ),
    );
  }
}
