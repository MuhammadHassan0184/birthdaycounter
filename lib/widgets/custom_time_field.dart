// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

TextEditingController timeController = TextEditingController();

Widget timeField(BuildContext context) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: timeController,
      readOnly: true,
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: AppColors.white,
                  hourMinuteTextColor: AppColors.primary,
                  hourMinuteColor: AppColors.primary.withOpacity(0.1),
                  dialHandColor: AppColors.primary,
                  dialBackgroundColor: AppColors.primary.withOpacity(0.08),
                  entryModeIconColor: AppColors.primary,
                ),
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary, // header + OK button
                  onPrimary: Colors.white, // text on primary
                  onSurface: AppColors.black, // numbers color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary, // Cancel / OK
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          timeController.text = picked.format(context);
        }
      },

      decoration: InputDecoration(
        hintText: "Time",
        prefixIcon: Icon(Icons.access_time, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
    ),
  );
}
