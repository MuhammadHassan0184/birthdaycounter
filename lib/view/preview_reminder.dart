// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewReminder extends StatefulWidget {
  const PreviewReminder({super.key});

  @override
  State<PreviewReminder> createState() => _PreviewReminderState();
}

class _PreviewReminderState extends State<PreviewReminder> {
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
          "Preview Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(7)
              ),
              child: Row(
                children: [
                  Icon(Icons.edit, color: AppColors.primary, size: 15,),
                  Text("Edit", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),)
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            // profilecard
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 120),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImagePicker(controller: imageController),
        
                  SizedBox(width: 12),
        
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Full name shown
                        Text(
                          "Muhammad Hassan",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                          softWrap: true, // allows multi-line
                        ),
        
                        SizedBox(height: 4),
        
                        Text("10 days Remaining", style: TextStyle(fontSize: 12)),
        
                        SizedBox(height: 10),
        
                        Chip(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          side: BorderSide(color: AppColors.primary),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          label: Text(
                            "Birthday",
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
            // UserDetails
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
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
                        child: Icon(Icons.cake_outlined, color: AppColors.primary,),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Birthday",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "06 November 2006",
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
                        "Friends",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.grey),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "+92 320-4660490",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Divider(color: AppColors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "mail@gmail.com",
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
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac lectus luctus, consectetur nisi vitae, ultrices metus. Nullam volutpat tellus in eros auctor, dignissim tincidunt risus feugiat.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
