// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomReminderCard extends StatelessWidget {
  final Reminder reminder;

  const CustomReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesName.previewReminder,
          arguments: {
            "name": reminder.name,
            "phone": reminder.phone,
            "email": reminder.email,
            "relationship": reminder.relationship,
            "reminderType": reminder.reminderType,
            "date": reminder.date,
            "time": reminder.time,
            "wish": reminder.wish,
            "remainingDays": reminder.remainingDays,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: reminder.imageUrl != null && reminder.imageUrl!.isNotEmpty
    ? Image.file(
        File(reminder.imageUrl!),
        fit: BoxFit.cover,
      )
    : Image.asset(
        "assets/imageicon.png",
        fit: BoxFit.cover,
      ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    reminder.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reminder.date,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${reminder.reminderType} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "(${reminder.remainingDays} Days)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showReminderMenu(context);
                  },
                ),
                SizedBox(
                  height: 26,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      reminder.relationship,
                      style: TextStyle(fontSize: 11, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showReminderMenu(BuildContext context) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final Offset topRight = button.localToGlobal(
    Offset(button.size.width, 0),
    ancestor: overlay,
  );

  final RelativeRect position = RelativeRect.fromLTRB(
    topRight.dx,
    topRight.dy,
    overlay.size.width - topRight.dx,
    overlay.size.height - topRight.dy,
  );

  await showMenu(
    color: AppColors.white,
    context: context,
    position: position,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    items: [
      PopupMenuItem(
        enabled: false,
        child: Text(
          "Robert Fox",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Edit Reminder"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Delete Reminder"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'preview',
        onTap: () {
          Get.toNamed(AppRoutesName.previewReminder);
        },
        child: Row(
          children: [
            Icon(Icons.remove_red_eye, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Preview Reminder"),
          ],
        ),
      ),
    ],
  );
}


// import 'dart:io';

// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomReminderCard extends StatelessWidget {
//   final Reminder reminder;

//   const CustomReminderCard({super.key, required this.reminder});
  

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(
//           AppRoutesName.previewReminder,
//           arguments: {
//             "name": reminder.name,
//             "phone": reminder.phone,
//             "email": reminder.email,
//             "relationship": reminder.relationship,
//             "reminderType": reminder.reminderType,
//             "date": reminder.date,
//             "time": reminder.time,
//             "wish": reminder.wish,
//             "remainingDays": reminder.remainingDays,
//           },
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//         padding: const EdgeInsets.all(10),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: AppColors.grey.withOpacity(0.2)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Container(
//             //   width: 70,
//             //   height: 70,
//             //   clipBehavior: Clip.antiAlias,
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(10),
//             //   ),
//             //   child: reminder.imageUrl != null
//             //       ? Image.network(reminder.imageUrl!, fit: BoxFit.cover)
//             //       : Image.asset("assets/my.jpg", fit: BoxFit.cover),
//             // ),
//             Container(
//   width: 70,
//   height: 70,
//   clipBehavior: Clip.antiAlias,
//   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//   child: reminder.localImagePath != null
//       ? (!kIsWeb
//           ? Image.file(File(reminder.localImagePath!), fit: BoxFit.cover)
//           : Image.memory(
//               Uint8List.fromList(reminder.localImagePath!
//                   .codeUnits), // If saved as string bytes
//               fit: BoxFit.cover,
//             ))
//       : Image.asset("assets/imageicon.png", fit: BoxFit.cover),
// ),










//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     reminder.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     reminder.date,
//                     style: const TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         "${reminder.reminderType} ",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                       Text(
//                         "(${reminder.remainingDays} Days)",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.more_vert),
//                   onPressed: () {
//                     _showReminderMenu(context);
//                   },
//                 ),
//                 SizedBox(
//                   height: 26,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       reminder.relationship,
//                       style: TextStyle(fontSize: 11, color: AppColors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _showReminderMenu(BuildContext context) async {
//   final RenderBox button = context.findRenderObject() as RenderBox;
//   final RenderBox overlay =
//       Overlay.of(context).context.findRenderObject() as RenderBox;

//   final Offset topRight = button.localToGlobal(
//     Offset(button.size.width, 0),
//     ancestor: overlay,
//   );

//   final RelativeRect position = RelativeRect.fromLTRB(
//     topRight.dx,
//     topRight.dy,
//     overlay.size.width - topRight.dx,
//     overlay.size.height - topRight.dy,
//   );

//   await showMenu(
//     color: AppColors.white,
//     context: context,
//     position: position,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     items: [
//       PopupMenuItem(
//         enabled: false,
//         child: Text(
//           "Robert Fox",
//           style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
//         ),
//       ),
//       PopupMenuItem(
//         value: 'edit',
//         child: Row(
//           children: [
//             Icon(Icons.edit, color: AppColors.primary, size: 18),
//             SizedBox(width: 10),
//             Text("Edit Reminder"),
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         value: 'delete',
//         child: Row(
//           children: [
//             Icon(Icons.delete, color: AppColors.primary, size: 18),
//             SizedBox(width: 10),
//             Text("Delete Reminder"),
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         value: 'preview',
//         onTap: () {
//           Get.toNamed(AppRoutesName.previewReminder);
//         },
//         child: Row(
//           children: [
//             Icon(Icons.remove_red_eye, color: AppColors.primary, size: 18),
//             SizedBox(width: 10),
//             Text("Preview Reminder"),
//           ],
//         ),
//       ),
//     ],
//   );
// }
