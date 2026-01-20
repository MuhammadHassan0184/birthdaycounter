// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final IconData icon;
  final IconData? suicon;
  final String? Function(String?)? validation;

  const CustomFormField({
    super.key,
    required this.label,
    required this.icon,
    this.suicon,
    this.validation,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool showpass = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      obscureText: showpass,
      textAlignVertical: TextAlignVertical.center,
      // keyboardType:
      //     widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.bggrey.withOpacity(0.2), // light grey bg

        prefixIcon: Icon(widget.icon, color: AppColors.grey, size: 20),

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
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.1),
            width: 0.9,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.1),
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
