// ignore_for_file: library_private_types_in_public_api, file_names, must_be_immutable, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSecondryField extends StatefulWidget {
  final String label;
  final IconData icon;
  final IconData? suicon;
  VoidCallback? onTap;
  final String? Function(String?)? validation;

  CustomSecondryField({
    super.key,
    required this.label,
    required this.icon,
    this.suicon,
    this.onTap,
    this.validation,
  });

  @override
  _CustomSecondryFieldState createState() => _CustomSecondryFieldState();
}

class _CustomSecondryFieldState extends State<CustomSecondryField> {
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      obscureText: widget.suicon != null ? showpass : false,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: AppColors.primary, size: 20),

        /// ✅ FIXED SUFFIX ICON
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
      color: AppColors.black.withOpacity(0.3),
      width: 0.9,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: AppColors.black.withOpacity(0.3),
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
