// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/controllers/image_picker_controller.dart';
// import 'package:birthdaycounter/controllers/reminder_controller.dart';
// import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
// import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
// import 'package:birthdaycounter/widgets/custom_button.dart';
// import 'package:birthdaycounter/widgets/custom_date_field.dart';
// import 'package:birthdaycounter/widgets/custom_time_field.dart';
// import 'package:birthdaycounter/widgets/custom_wish_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

// class AddReminder extends StatefulWidget {
//   const AddReminder({super.key});
//   @override
//   State<AddReminder> createState() => _AddReminderState();
// }

// class _AddReminderState extends State<AddReminder> {
//   final ImagePickerController imageController = ImagePickerController();
//   final ReminderController reminderCtrl = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         leading: IconButton(
//           onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
//           icon: Icon(Icons.arrow_back, color: AppColors.white),
//         ),
//         title: Text(
//           "Add Reminder",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 30),
//               ProfileImagePicker(
//                 controller: imageController,
//                 onImagePicked: () {
//                   print("Image picked: ${imageController.imagePath}");
//                   reminderCtrl.imagePath.value = imageController.imagePath ?? '';
//                 },
//               ),
//               SizedBox(height: 25),

//               // Name
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Name",
//                   icon: Icons.person,
//                   controller: reminderCtrl.nameController,
//                   onChanged: (val) => reminderCtrl.name.value = val,
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Relationship
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Relationship",
//                   icon: Icons.group,
//                   controller: reminderCtrl.relationshipController,
//                   onChanged: (val) {},
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Phone
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Phone (Optional)",
//                   icon: Icons.call,
//                   controller: reminderCtrl.phoneController,
//                   onChanged: (val) {},
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Email
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Email (Optional)",
//                   icon: Icons.email,
//                   controller: reminderCtrl.emailController,
//                   onChanged: (val) {},
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Reminder Type
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Reminder Type",
//                   icon: Icons.cake,
//                   controller: reminderCtrl.reminderTypeController,
//                   onChanged: (val) {},
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Date & Time
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: dateField(context),
//                   ),
//                   SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: timeField(context),
//                   ),
//                   SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: wishField(controller: reminderCtrl.wishController),
//                   ),

//                   SizedBox(height: 20),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 50),
//                     child: CustomButton(
//                       label: "Add",
//                       onTap: () {
//                         if (reminderCtrl.nameController.text.isEmpty ||
//                             reminderCtrl.relationshipController.text.isEmpty ||
//                             reminderCtrl.reminderTypeController.text.isEmpty ||
//                             reminderCtrl.dateController.text.isEmpty ||
//                             reminderCtrl.timeController.text.isEmpty ||
//                             reminderCtrl.wishController.text.isEmpty) {
//                           Get.snackbar(
//                             "Error",
//                             "Please fill all required fields",
//                             backgroundColor: AppColors.primary,
//                             colorText: AppColors.white,
//                           );
//                           return;
//                         }

//                         // Save values
//                         reminderCtrl.name.value =
//                             reminderCtrl.nameController.text;
//                         reminderCtrl.relationship.value =
//                             reminderCtrl.relationshipController.text;
//                         reminderCtrl.phone.value =
//                             reminderCtrl.phoneController.text;
//                         reminderCtrl.email.value =
//                             reminderCtrl.emailController.text;
//                         reminderCtrl.reminderType.value =
//                             reminderCtrl.reminderTypeController.text;
//                         reminderCtrl.date.value =
//                             reminderCtrl.dateController.text;
//                         reminderCtrl.time.value =
//                             reminderCtrl.timeController.text;
//                         reminderCtrl.wish.value =
//                             reminderCtrl.wishController.text;

//                         reminderCtrl.addReminder();
//                         Get.back(); // Go back to home
//                       },
//                     ),
//                   ),

//                   SizedBox(height: 20),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// ignore_for_file: unused_import

import 'dart:io';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/widgets/custom_date_field.dart';
import 'package:birthdaycounter/widgets/custom_time_field.dart';
import 'package:birthdaycounter/widgets/custom_wish_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReminder extends StatefulWidget {
  final Reminder? reminder; // null if adding, not null if editing

  const AddReminder({super.key, this.reminder});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final ImagePickerController imageController = ImagePickerController();
  final ReminderController reminderCtrl = Get.find();

  @override
  void initState() {
    super.initState();

    // Prefill controllers if editing
    if (widget.reminder != null) {
      final r = widget.reminder!;
      reminderCtrl.nameController.text = r.name;
      reminderCtrl.relationshipController.text = r.relationship;
      reminderCtrl.phoneController.text = r.phone;
      reminderCtrl.emailController.text = r.email;
      reminderCtrl.reminderTypeController.text = r.reminderType;
      reminderCtrl.dateController.text = r.date;
      reminderCtrl.timeController.text = r.time;
      reminderCtrl.wishController.text = r.wish;
      reminderCtrl.imagePath.value = r.imageUrl ?? '';

      // Update obs values
      reminderCtrl.name.value = r.name;
      reminderCtrl.relationship.value = r.relationship;
      reminderCtrl.phone.value = r.phone;
      reminderCtrl.email.value = r.email;
      reminderCtrl.reminderType.value = r.reminderType;
      reminderCtrl.date.value = r.date;
      reminderCtrl.time.value = r.time;
      reminderCtrl.wish.value = r.wish;
    }
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
          widget.reminder == null ? "Add Reminder" : "Edit Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              ProfileImagePicker(
                controller: imageController,
                onImagePicked: () {
                  reminderCtrl.imagePath.value = imageController.imagePath ?? '';
                },
              ),
              SizedBox(height: 25),

              // Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Name",
                  icon: Icons.person,
                  controller: reminderCtrl.nameController,
                  onChanged: (val) => reminderCtrl.name.value = val,
                ),
              ),
              SizedBox(height: 12),

              // Relationship
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Relationship",
                  icon: Icons.group,
                  controller: reminderCtrl.relationshipController,
                  onChanged: (val) => reminderCtrl.relationship.value = val,
                ),
              ),
              SizedBox(height: 12),

              // Phone
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Phone (Optional)",
                  icon: Icons.call,
                  controller: reminderCtrl.phoneController,
                  onChanged: (val) => reminderCtrl.phone.value = val,
                ),
              ),
              SizedBox(height: 12),

              // Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Email (Optional)",
                  icon: Icons.email,
                  controller: reminderCtrl.emailController,
                  onChanged: (val) => reminderCtrl.email.value = val,
                ),
              ),
              SizedBox(height: 12),

              // Reminder Type
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Reminder Type",
                  icon: Icons.cake,
                  controller: reminderCtrl.reminderTypeController,
                  onChanged: (val) => reminderCtrl.reminderType.value = val,
                ),
              ),
              SizedBox(height: 12),

              // Date & Time
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: dateField(context),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: timeField(context),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: wishField(controller: reminderCtrl.wishController),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomButton(
                      label: widget.reminder == null ? "Add" : "Update",
                      onTap: () {
                        if (reminderCtrl.nameController.text.isEmpty ||
                            reminderCtrl.relationshipController.text.isEmpty ||
                            reminderCtrl.reminderTypeController.text.isEmpty ||
                            reminderCtrl.dateController.text.isEmpty ||
                            reminderCtrl.timeController.text.isEmpty ||
                            reminderCtrl.wishController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please fill all required fields",
                            backgroundColor: AppColors.primary,
                            colorText: AppColors.white,
                          );
                          return;
                        }

                        // Save obs values
                        reminderCtrl.name.value = reminderCtrl.nameController.text;
                        reminderCtrl.relationship.value = reminderCtrl.relationshipController.text;
                        reminderCtrl.phone.value = reminderCtrl.phoneController.text;
                        reminderCtrl.email.value = reminderCtrl.emailController.text;
                        reminderCtrl.reminderType.value = reminderCtrl.reminderTypeController.text;
                        reminderCtrl.date.value = reminderCtrl.dateController.text;
                        reminderCtrl.time.value = reminderCtrl.timeController.text;
                        reminderCtrl.wish.value = reminderCtrl.wishController.text;

                        if (widget.reminder == null) {
                          // Add new reminder
                          reminderCtrl.addReminder();
                        } else {
                          // Update existing reminder
                          reminderCtrl.updateReminder(widget.reminder!);
                        }

                        Get.back();
                      },
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
