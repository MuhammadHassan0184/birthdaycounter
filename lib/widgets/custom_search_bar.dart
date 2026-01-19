import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.grey),
          hint: Text(
            "Search",
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
