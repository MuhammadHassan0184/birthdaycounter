// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:birthdaycounter/view/add_reminder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomReminderCard extends StatelessWidget {
  final Reminder reminder;
  final ReminderController controller = Get.find();

  CustomReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesName.previewReminder,
          arguments: reminder.toJson(),
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
                  ? Image.file(File(reminder.imageUrl!), fit: BoxFit.cover)
                  : Image.asset("assets/imagei.png", fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "(${reminder.remainingDays} Days)",
                        style: TextStyle(
                          fontSize: 12,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showReminderMenu(context, reminder);
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

  void _showReminderMenu(BuildContext context, Reminder reminder) async {
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

    // Show popup menu
    final selected = await showMenu<String>(
      context: context,
      position: position,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Text(
            reminder.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
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

    // Handle selection
    final controller = Get.find<ReminderController>();

    switch (selected) {
      case 'edit':
        // Navigate to AddReminder screen with prefilled data
        Get.to(() => AddReminder(reminder: reminder));
        break;

      case 'delete':
        Get.dialog(
          AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Delete Reminder?",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              "Are you sure you want to delete ${reminder.name}?",
              style: TextStyle(color: Colors.black87),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  controller.deleteReminder(reminder);
                  Get.back();
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        break;

      case 'preview':
        // Navigate to preview screen
        Get.toNamed(
          AppRoutesName.previewReminder,
          arguments: reminder.toJson(),
        );
        break;
    }
  }
}
