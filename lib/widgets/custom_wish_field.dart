// ignore_for_file: unnecessary_import, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

// This should be outside any widget, accessible globally
final TextEditingController wishController = TextEditingController();

Widget wishField() {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: wishController, // <-- use the shared controller
      decoration: InputDecoration(
        hintText: "Wish",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12), // centers the icon
          child: SvgPicture.asset(
            "assets/wish.svg", //  your SVG file
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              AppColors.primary, // optional color for monochrome SVG
              BlendMode.srcIn,
            ),
          ),
        ),

        suffixIcon: IconButton(
          onPressed: () {
            Get.toNamed(AppRoutesName.wishesScreen);
          },
          icon: Icon(Icons.add),
        ),
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
    ),
  );
}
