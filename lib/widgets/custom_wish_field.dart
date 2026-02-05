// ignore_for_file: unnecessary_import, deprecated_member_use

import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:get/get_core/get_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// This should be outside any widget, accessible globally
final TextEditingController wishController = TextEditingController();

Widget wishField({required TextEditingController controller}) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: controller,

      onChanged: (val) {
        final reminderCtrl = Get.find<ReminderController>();
        reminderCtrl.wish.value = val; // ✅ bind
      },

      decoration: InputDecoration(
        hintText: "Wish",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/wish.svg",
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          
        ),
        suffixIcon:
            IconButton(
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
