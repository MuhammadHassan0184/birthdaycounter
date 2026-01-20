// ignore_for_file: unnecessary_import, avoid_print

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/widgets/custom_date_field.dart';
import 'package:birthdaycounter/widgets/custom_dropdown_field.dart';
import 'package:birthdaycounter/widgets/custom_time_field.dart';
import 'package:birthdaycounter/widgets/custom_wish_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {

  final ImagePickerController imageController = ImagePickerController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoutesName.homeScreen);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Add Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
        
              ProfileImagePicker(controller: imageController),
        
              SizedBox(height: 25),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Full Name",
                  icon: Icons.person,
                  // prefixImage: "assets/personsvg.svg",
                ),
              ),
        
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondaryDropdown(
                  hint: "Relationship",
                  // icon: Icons.favorite_rounded,
                  prefixImage: "assets/relationship.svg",
                  items: [
                    "Brother",
                    "Sister",
                    "Father",
                    "Mother",
                    "Friend",
                    "Best Friend",
                  ],
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select relation";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    print("Selected: $value");
                  },
                ),
              ),
        
              SizedBox(height: 12),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Phone (Optional)",
                  icon: Icons.call,
                ),
              ),
        
              SizedBox(height: 12),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Email (Optional)",
                  icon: Icons.email,
                ),
              ),
        
              SizedBox(height: 12),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondaryDropdown(
                  hint: "Reminder Type",
                  // icon: Icons.cake_rounded,
                  prefixImage: "assets/cake.svg",
                  items: ["Birthday", "Engagement", "Anniversary"],
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select relation";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    print("Selected: $value");
                  },
                ),
              ),
        
              SizedBox(height: 12),
        
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
                    child: wishField(),
                  ),
        
                  SizedBox(height: 20,),
        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomButton(label: "Add"),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
