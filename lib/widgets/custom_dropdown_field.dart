// ignore_for_file: library_private_types_in_public_api, file_names, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ✅ for SVG support

class CustomSecondaryDropdown extends StatefulWidget {
  final String hint;
  final IconData? icon; // optional icon
  final String? prefixImage; // SVG path
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validation;

  const CustomSecondaryDropdown({
    super.key,
    required this.hint,
    this.icon,
    this.prefixImage,
    required this.items,
    this.value,
    this.onChanged,
    this.validation,
  }) : assert(
         icon != null || prefixImage != null,
         'Either icon or prefixImage must be provided',
       );

  @override
  _CustomSecondaryDropdownState createState() =>
      _CustomSecondaryDropdownState();
}

class _CustomSecondaryDropdownState extends State<CustomSecondaryDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      validator: widget.validation,
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
      decoration: InputDecoration(
        prefixIcon: widget.prefixImage != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  widget.prefixImage!,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : Icon(widget.icon, color: AppColors.primary, size: 20),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: AppColors.grey, fontSize: 14),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged?.call(value);
      },
    );
  }
}
