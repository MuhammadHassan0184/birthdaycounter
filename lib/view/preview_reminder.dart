// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewReminder extends StatefulWidget {
  const PreviewReminder({super.key});

  @override
  State<PreviewReminder> createState() => _PreviewReminderState();
}

class _PreviewReminderState extends State<PreviewReminder> {
  final ImagePickerController imageController = ImagePickerController();

  late Map<String, dynamic> reminderData;

  @override
  void initState() {
    super.initState();
    reminderData = Get.arguments ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Preview Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 120),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImagePicker(controller: imageController, onImagePicked: () {  },),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminderData['name'] ?? "Your Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${reminderData['remainingDays'] ?? 0} days Remaining",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 10),
                        Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          side: BorderSide(color: AppColors.primary),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          label: Text(
                            reminderData['reminderType'] ?? "Birthday",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.cake_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reminderData['reminderType'] ?? "Birthday",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            reminderData['date'] ?? "yyyy-mm-dd",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Relationship",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        reminderData['relationship'] ?? "Friends",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.grey.withOpacity(0.25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        reminderData['phone'] ?? "+92 000-0000000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.grey.withOpacity(0.25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        reminderData['email'] ?? "mail@gmail.com",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Wish",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(height: 7),
                  Text(reminderData['wish'] ?? "Your wish will appear here"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:birthdaycounter/controllers/image_picker_controller.dart';

// class PreviewReminder extends StatefulWidget {
//   const PreviewReminder({super.key});

//   @override
//   State<PreviewReminder> createState() => _PreviewReminderState();
// }

// class _PreviewReminderState extends State<PreviewReminder> {
//   final ImagePickerController imageController = ImagePickerController();
//   late Map<String, dynamic> reminderData;

//   @override
//   void initState() {
//     super.initState();
//     reminderData = Get.arguments ?? {};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         leading: IconButton(
//           onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
//           icon: Icon(Icons.arrow_back, color: AppColors.white),
//         ),
//         title: Text("Preview Reminder", style: TextStyle(color: AppColors.white)),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 15),
//               padding: EdgeInsets.all(12),
//               width: double.infinity,
//               constraints: BoxConstraints(minHeight: 120),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.grey.withOpacity(0.25)),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   ProfileImagePicker(controller: imageController),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(reminderData['name'] ?? "Your Name", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
//                         SizedBox(height: 4),
//                         Text("${reminderData['remainingDays'] ?? 0} days Remaining"),
//                         SizedBox(height: 10),
//                         Chip(
//                           visualDensity: VisualDensity.compact,
//                           side: BorderSide(color: AppColors.primary),
//                           backgroundColor: AppColors.primary.withOpacity(0.1),
//                           label: Text(reminderData['reminderType'] ?? "Birthday", style: TextStyle(color: AppColors.primary)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 15),
//             // Details container...
//             // Use reminderData["phone"], reminderData["email"], etc.
//           ],
//         ),
//       ),
//     );
//   }
// }
