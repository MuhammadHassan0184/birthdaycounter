// ignore_for_file: unnecessary_import

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
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
        prefixIcon: Icon(Icons.card_giftcard, color: AppColors.primary),
        suffixIcon: IconButton(
          onPressed: () {
            Get.toNamed(AppRoutesName.wishesScreen);
          },
          icon: Icon(Icons.add),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

