// ignore_for_file: library_private_types_in_public_api, file_names, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomSecondaryDropdown extends StatefulWidget {
  final String hint;
  final IconData icon;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validation;

  const CustomSecondaryDropdown({
    super.key,
    required this.hint,
    required this.icon,
    required this.items,
    this.value,
    this.onChanged,
    this.validation,
  });

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
        prefixIcon: Icon(widget.icon, color: AppColors.primary, size: 20),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.bggrey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary, width: 0.5),
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
