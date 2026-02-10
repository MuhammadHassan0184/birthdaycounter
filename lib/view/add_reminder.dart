// // ignore_for_file: unused_import

// import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
// import 'package:birthdaycounter/controllers/image_picker_controller.dart';
// import 'package:birthdaycounter/controllers/reminder_controller.dart';
// import 'package:birthdaycounter/Services/notification_service.dart';
// import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/widgets/custom_date_field.dart';
// import 'package:birthdaycounter/widgets/custom_time_field.dart';
// import 'package:birthdaycounter/widgets/custom_wish_field.dart';
// import 'package:birthdaycounter/widgets/custom_button.dart';
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'dart:io';

// class AddReminder extends StatefulWidget {
//   final Reminder? reminder; // null if adding, not null if editing

//   const AddReminder({super.key, this.reminder});

//   @override
//   State<AddReminder> createState() => _AddReminderState();
// }

// class _AddReminderState extends State<AddReminder> {
//   final ImagePickerController imageController = ImagePickerController();
//   final ReminderController reminderCtrl = Get.find();

//   @override
//   void initState() {
//     super.initState();

//     // If editing a reminder
//     if (widget.reminder != null) {
//       final r = widget.reminder!;
//       reminderCtrl.nameController.text = r.name;
//       reminderCtrl.relationshipController.text = r.relationship;
//       reminderCtrl.phoneController.text = r.phone;
//       reminderCtrl.emailController.text = r.email;
//       reminderCtrl.reminderTypeController.text = r.reminderType;
//       reminderCtrl.dateController.text = r.date;
//       reminderCtrl.timeController.text = r.time;
//       reminderCtrl.wishController.text = r.wish;

//       // Prefill image
//       if (r.imageUrl != null && r.imageUrl!.isNotEmpty) {
//         reminderCtrl.imagePath.value = r.imageUrl!;
//         imageController.imagePath = r.imageUrl!;
//       } else {
//         reminderCtrl.imagePath.value = '';
//         imageController.imagePath = null;
//       }

//       // Update obs values
//       reminderCtrl.name.value = r.name;
//       reminderCtrl.relationship.value = r.relationship;
//       reminderCtrl.phone.value = r.phone;
//       reminderCtrl.email.value = r.email;
//       reminderCtrl.reminderType.value = r.reminderType;
//       reminderCtrl.date.value = r.date;
//       reminderCtrl.time.value = r.time;
//       reminderCtrl.wish.value = r.wish;
//     } else {
//       // If adding a NEW reminder, clear all fields
//       reminderCtrl.nameController.clear();
//       reminderCtrl.relationshipController.clear();
//       reminderCtrl.phoneController.clear();
//       reminderCtrl.emailController.clear();
//       reminderCtrl.reminderTypeController.clear();
//       reminderCtrl.dateController.clear();
//       reminderCtrl.timeController.clear();
//       reminderCtrl.wishController.clear();
//       reminderCtrl.imagePath.value = '';
//       imageController.imagePath = null;

//       reminderCtrl.name.value = '';
//       reminderCtrl.relationship.value = '';
//       reminderCtrl.phone.value = '';
//       reminderCtrl.email.value = '';
//       reminderCtrl.reminderType.value = '';
//       reminderCtrl.date.value = '';
//       reminderCtrl.time.value = '';
//       reminderCtrl.wish.value = '';
//     }
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
//         title: Text(
//           widget.reminder == null ? "Add Reminder" : "Edit Reminder",
//           style: TextStyle(
//             color: AppColors.white,
//             fontWeight: FontWeight.w400,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               ProfileImagePicker(
//                 controller: imageController,
//                 onImagePicked: () {
//                   // Update observable when user picks a new image
//                   reminderCtrl.imagePath.value =
//                       imageController.imagePath ?? '';
//                 },
//               ),
//               const SizedBox(height: 25),

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
//               const SizedBox(height: 12),

//               // Relationship
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 15),
//               //   child: CustomSecondryField(
//               //     label: "Relationship",
//               //     icon: Icons.group,
//               //     controller: reminderCtrl.relationshipController,
//               //     onChanged: (val) => reminderCtrl.relationship.value = val,
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Relationship",
//                   icon: Icons.group,
//                   controller: reminderCtrl.relationshipController,
//                   isDropdown: true,
//                   items: const [
//                     "Father",
//                     "Mother",
//                     "Brother",
//                     "Sister",
//                     "Friend",
//                     "Wife",
//                     "Husband",
//                     "Other",
//                   ],
//                   onChanged: (val) => reminderCtrl.relationship.value = val,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Phone
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 15),
//               //   child: CustomSecondryField(
//               //     label: "Phone (Optional)",
//               //     icon: Icons.call,
//               //     controller: reminderCtrl.phoneController,
//               //     onChanged: (val) => reminderCtrl.phone.value = val,
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Phone (Optional)",
//                   icon: Icons.call,
//                   controller: reminderCtrl.phoneController,
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly, // 🔒 numbers only
//                   ],
//                   validation: (value) {
//                     if (value == null || value.isEmpty) {
//                       return ""; // ✅ optional
//                     }
//                     if (value.length < 7 || value.length > 15) {
//                       return "Enter a valid phone number";
//                     }
//                     return "";
//                   },
//                   onChanged: (val) => reminderCtrl.phone.value = val,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Email
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Email (Optional)",
//                   icon: Icons.email,
//                   controller: reminderCtrl.emailController,
//                   onChanged: (val) => reminderCtrl.email.value = val,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Reminder Type
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomSecondryField(
//                   label: "Reminder Type",
//                   icon: Icons.cake,
//                   controller: reminderCtrl.reminderTypeController,
//                   onChanged: (val) => reminderCtrl.reminderType.value = val,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Date & Time
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: dateField(context),
//               ),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: timeField(context),
//               ),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: wishField(controller: reminderCtrl.wishController),
//               ),

//               const SizedBox(height: 20),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: CustomButton(
//                   label: widget.reminder == null ? "Add" : "Update",
//                   onTap: () {
//                     if (reminderCtrl.nameController.text.isEmpty ||
//                         reminderCtrl.relationshipController.text.isEmpty ||
//                         reminderCtrl.reminderTypeController.text.isEmpty ||
//                         reminderCtrl.dateController.text.isEmpty ||
//                         reminderCtrl.timeController.text.isEmpty ||
//                         reminderCtrl.wishController.text.isEmpty) {
//                       Get.snackbar(
//                         "Error",
//                         "Please fill all required fields",
//                         backgroundColor: AppColors.primary,
//                         colorText: AppColors.white,
//                       );
//                       return;
//                     }

//                     // Save observable values
//                     reminderCtrl.name.value = reminderCtrl.nameController.text;
//                     reminderCtrl.relationship.value =
//                         reminderCtrl.relationshipController.text;
//                     reminderCtrl.phone.value =
//                         reminderCtrl.phoneController.text;
//                     reminderCtrl.email.value =
//                         reminderCtrl.emailController.text;
//                     reminderCtrl.reminderType.value =
//                         reminderCtrl.reminderTypeController.text;
//                     reminderCtrl.date.value = reminderCtrl.dateController.text;
//                     reminderCtrl.time.value = reminderCtrl.timeController.text;
//                     reminderCtrl.wish.value = reminderCtrl.wishController.text;

//                     if (widget.reminder == null) {
//                       reminderCtrl.addReminder();
//                     } else {
//                       reminderCtrl.updateReminder(widget.reminder!);
//                     }

//                     Get.back();
//                   },
//                   title: '',
//                 ),
//               ),

//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: unused_import

import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/Services/notification_service.dart';
import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_date_field.dart';
import 'package:birthdaycounter/widgets/custom_time_field.dart';
import 'package:birthdaycounter/widgets/custom_wish_field.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddReminder extends StatefulWidget {
  final Reminder? reminder; // null if adding, not null if editing

  const AddReminder({super.key, this.reminder});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final ImagePickerController imageController = ImagePickerController();
  final ReminderController reminderCtrl = Get.find();

  // ✅ Add Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // If editing a reminder
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

      // Prefill image
      if (r.imageUrl != null && r.imageUrl!.isNotEmpty) {
        reminderCtrl.imagePath.value = r.imageUrl!;
        imageController.imagePath = r.imageUrl!;
      } else {
        reminderCtrl.imagePath.value = '';
        imageController.imagePath = null;
      }

      // Update obs values
      reminderCtrl.name.value = r.name;
      reminderCtrl.relationship.value = r.relationship;
      reminderCtrl.phone.value = r.phone;
      reminderCtrl.email.value = r.email;
      reminderCtrl.reminderType.value = r.reminderType;
      reminderCtrl.date.value = r.date;
      reminderCtrl.time.value = r.time;
      reminderCtrl.wish.value = r.wish;
    } else {
      // If adding a NEW reminder, clear all fields
      reminderCtrl.nameController.clear();
      reminderCtrl.relationshipController.clear();
      reminderCtrl.phoneController.clear();
      reminderCtrl.emailController.clear();
      reminderCtrl.reminderTypeController.clear();
      reminderCtrl.dateController.clear();
      reminderCtrl.timeController.clear();
      reminderCtrl.wishController.clear();
      reminderCtrl.imagePath.value = '';
      imageController.imagePath = null;

      reminderCtrl.name.value = '';
      reminderCtrl.relationship.value = '';
      reminderCtrl.phone.value = '';
      reminderCtrl.email.value = '';
      reminderCtrl.reminderType.value = '';
      reminderCtrl.date.value = '';
      reminderCtrl.time.value = '';
      reminderCtrl.wish.value = '';
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
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // ✅ Wrap everything in Form
            child: Column(
              children: [
                const SizedBox(height: 30),
                ProfileImagePicker(
                  controller: imageController,
                  onImagePicked: () {
                    // Update observable when user picks a new image
                    reminderCtrl.imagePath.value =
                        imageController.imagePath ?? '';
                  },
                ),
                const SizedBox(height: 25),

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
                const SizedBox(height: 12),

                // Relationship
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSecondryField(
                    label: "Relationship",
                    icon: Icons.group,
                    controller: reminderCtrl.relationshipController,
                    isDropdown: true,
                    items: const [
                      "Father",
                      "Mother",
                      "Brother",
                      "Sister",
                      "Friend",
                      "Wife",
                      "Husband",
                      "Other",
                    ],
                    onChanged: (val) => reminderCtrl.relationship.value = val,
                  ),
                ),

                const SizedBox(height: 12),

                // Phone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSecondryField(
                    label: "Phone (Optional)",
                    icon: Icons.call,
                    controller: reminderCtrl.phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // 🔒 numbers only
                    ],
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return null; // ✅ optional
                      }
                      if (value.length < 7 || value.length > 15) {
                        return "Enter a valid phone number";
                      }
                      return null; // ✅ valid
                    },
                    onChanged: (val) => reminderCtrl.phone.value = val,
                  ),
                ),

                const SizedBox(height: 12),

                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSecondryField(
                    label: "Email (Optional)",
                    icon: Icons.email,
                    controller: reminderCtrl.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return null; // ✅ optional
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null; // ✅ valid
                    },
                    onChanged: (val) => reminderCtrl.email.value = val,
                  ),
                ),

                const SizedBox(height: 12),

                // Reminder Type
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSecondryField(
                    label: "Reminder Type",
                    icon: Icons.cake,
                    controller: reminderCtrl.reminderTypeController,
                    isDropdown: true,
                    items: const [
                      "Birthday",
                      "Anniversary",
                      "Engagement",
                      "Custom Event",
                    ],
                    onChanged: (val) => reminderCtrl.reminderType.value = val,
                  ),
                ),

                const SizedBox(height: 12),

                // Date & Time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: dateField(context),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: timeField(context),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: wishField(controller: reminderCtrl.wishController),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomButton(
                    label: widget.reminder == null ? "Add" : "Update",
                    onTap: () {
                      // ✅ Check form validation
                      if (!_formKey.currentState!.validate()) {
                        return; // stop if invalid
                      }

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

                      // Save observable values
                      reminderCtrl.name.value =
                          reminderCtrl.nameController.text;
                      reminderCtrl.relationship.value =
                          reminderCtrl.relationshipController.text;
                      reminderCtrl.phone.value =
                          reminderCtrl.phoneController.text;
                      reminderCtrl.email.value =
                          reminderCtrl.emailController.text;
                      reminderCtrl.reminderType.value =
                          reminderCtrl.reminderTypeController.text;
                      reminderCtrl.date.value =
                          reminderCtrl.dateController.text;
                      reminderCtrl.time.value =
                          reminderCtrl.timeController.text;
                      reminderCtrl.wish.value =
                          reminderCtrl.wishController.text;

                      if (widget.reminder == null) {
                        reminderCtrl.addReminder();
                      } else {
                        reminderCtrl.updateReminder(widget.reminder!);
                      }

                      Get.back();
                    },
                    title: '',
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
