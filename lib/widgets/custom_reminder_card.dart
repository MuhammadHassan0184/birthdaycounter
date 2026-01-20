// ignore_for_file: unused_element, unnecessary_import, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CustomReminderCard extends StatelessWidget {
  const CustomReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutesName.previewReminder);
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
            /// IMAGE
            Container(
              width: 70, // responsive enough for phones
              height: 70,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset("assets/my.jpg", fit: BoxFit.cover),
            ),
      
            const SizedBox(width: 10),
      
            /// TEXT SECTION (takes available space)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Muhammad Hassan",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "06-11-2006",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Birthday ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "(283 Days)",
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
      
            /// ACTIONS
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.end, // optional for other children
              children: [
                // Align icon to right
                Align(
                  alignment: Alignment.centerRight, // ✅ moves icon to right
                  child: Builder(
                    builder: (iconContext) {
                      return IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          _showReminderMenu(iconContext);
                        },
                      );
                    },
                  ),
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
                      "Friends",
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
