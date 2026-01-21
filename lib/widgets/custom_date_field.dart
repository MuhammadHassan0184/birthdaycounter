// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

TextEditingController dateController = TextEditingController();

Widget dateField(BuildContext context) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: dateController,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary, // header + selected date
                  onPrimary: Colors.white, // header text
                  onSurface: AppColors.black, // calendar text
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: AppColors.white,
                  headerBackgroundColor: AppColors.primary,
                  headerForegroundColor: Colors.white,
                  todayBackgroundColor: MaterialStateProperty.all(
                    AppColors.primary.withOpacity(0.15),
                  ),
                  todayForegroundColor: MaterialStateProperty.all(
                    AppColors.primary,
                  ),
                  dayForegroundColor: MaterialStateProperty.all(
                    AppColors.black,
                  ),
                  yearForegroundColor: MaterialStateProperty.all(
                    AppColors.black,
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary, // OK / Cancel
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          dateController.text = "${picked.month}/${picked.day}/${picked.year}";

        }

        if (picked != null) {
  final reminderCtrl = Get.find<ReminderController>();
  reminderCtrl.dateController.text = "${picked.month}/${picked.day}/${picked.year}";
  reminderCtrl.date.value = reminderCtrl.dateController.text; // ✅ bind
}


      },
      decoration: InputDecoration(
        hintText: "MM/DD/YYYY",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12), // centers the icon
          child: SvgPicture.asset(
            "assets/date.svg", // ✅ your SVG file
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              AppColors.primary, // optional color for monochrome SVG
              BlendMode.srcIn,
            ),
          ),
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
