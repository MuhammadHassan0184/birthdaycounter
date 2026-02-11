// // ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/controllers/reminder_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// TextEditingController timeController = TextEditingController();

// Widget timeField(BuildContext context) {
//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       controller: timeController,
//       readOnly: true,
//       onTap: () async {
//         TimeOfDay? picked = await showTimePicker(
//           context: context,
//           initialTime: TimeOfDay.now(),
//           builder: (context, child) {
//             return Theme(
//               data: Theme.of(context).copyWith(
//                 timePickerTheme: TimePickerThemeData(
//                   backgroundColor: AppColors.white,
//                   hourMinuteTextColor: AppColors.primary,
//                   hourMinuteColor: AppColors.primary.withOpacity(0.1),
//                   dialHandColor: AppColors.primary,
//                   dialBackgroundColor: AppColors.primary.withOpacity(0.08),
//                   entryModeIconColor: AppColors.primary,
//                 ),
//                 colorScheme: ColorScheme.light(
//                   primary: AppColors.primary, // header + OK button
//                   onPrimary: Colors.white, // text on primary
//                   onSurface: AppColors.black, // numbers color
//                 ),
//                 textButtonTheme: TextButtonThemeData(
//                   style: TextButton.styleFrom(
//                     foregroundColor: AppColors.primary, // Cancel / OK
//                   ),
//                 ),
//               ),
//               child: child!,
//             );
//           },
//         );

//         if (picked != null) {
//           final reminderCtrl = Get.find<ReminderController>();
//           reminderCtrl.timeController.text = picked.format(context);
//           reminderCtrl.time.value = reminderCtrl.timeController.text; // ✅ bind
//         }
//       },

//       decoration: InputDecoration(
//         hintText: "Time",
//         prefixIcon: Padding(
//           padding: const EdgeInsets.all(12), // centers the icon
//           child: SvgPicture.asset(
//             "assets/time.svg", // ✅ your SVG file
//             width: 20,
//             height: 20,
//             colorFilter: ColorFilter.mode(
//               AppColors.primary, // optional color for monochrome SVG
//               BlendMode.srcIn,
//             ),
//           ),
//         ),

// ignore_for_file: deprecated_member_use, use_build_context_synchronously

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: AppColors.black.withOpacity(0.2),
//             width: 0.9,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: AppColors.black.withOpacity(0.2),
//             width: 0.9,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: AppColors.black.withOpacity(0.25),
//             width: 0.6,
//           ),
//         ),
//       ),
//     ),
//   );
// }
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget timeField(BuildContext context) {
  final reminderCtrl = Get.find<ReminderController>();

  // Initialize the controller text with Rx value if empty
  if (reminderCtrl.timeController.text.isEmpty && reminderCtrl.time.value.isNotEmpty) {
    reminderCtrl.timeController.text = reminderCtrl.time.value;
  }

  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: reminderCtrl.timeController,
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
                  primary: AppColors.primary,
                  onPrimary: Colors.white,
                  onSurface: AppColors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final formattedTime = picked.format(context);
          reminderCtrl.timeController.text = formattedTime;
          reminderCtrl.time.value = formattedTime; // updates Rx for AddReminder logic
        }
      },
      decoration: InputDecoration(
        hintText: "Time",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/time.svg",
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.2), width: 0.9),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.2), width: 0.9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.25), width: 0.6),
        ),
      ),
    ),
  );
}
