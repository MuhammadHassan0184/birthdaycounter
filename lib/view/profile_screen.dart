import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
import 'package:birthdaycounter/widgets/Profile_Image/custom_profile_image.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePickerController imageController = ImagePickerController();

  // Controllers for fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        nameController.text = doc['fullName'] ?? '';
        emailController.text = user.email ?? '';

        // Load profile image if exists
        final savedImagePath = doc['profileImage'] ?? '';
        if (savedImagePath.isNotEmpty) {
          imageController.imagePath = savedImagePath;
        }
      }

      passwordController.text = '';
      confirmPasswordController.text = '';
      setState(() {});
    }
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Save name & profile image path
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'fullName': nameController.text.trim(),
          'profileImage': imageController.imagePath ?? '',
        },
        SetOptions(merge: true), // 🔹 creates doc if missing
      );

      // Update password if entered
      if (passwordController.text.trim().isNotEmpty) {
        await user.updatePassword(passwordController.text.trim());
      }

      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

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
          "Profile",
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
          child: Column(
            children: [
              SizedBox(height: 30),
              ProfileImagePicker(
                controller: imageController,
                onImagePicked: () {
                  setState(() {}); // update UI immediately after picking
                },
              ),

              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Name",
                  icon: Icons.person,
                  controller: nameController,
                  onChanged: (val) {},
                ),
              ),
              // SizedBox(height: 12),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: CustomSecondryField(
              //     label: "Email",
              //     icon: Icons.mail,
              //     controller: emailController,
              //     readOnly: true, // prevent editing email
              //   ),
              // ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Password",
                  icon: Icons.lock,
                  suicon: Icons.visibility,
                  controller: passwordController,
                  onChanged: (val) {},
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomSecondryField(
                  label: "Confirm Password",
                  icon: Icons.lock,
                  suicon: Icons.visibility,
                  controller: confirmPasswordController,
                  onChanged: (val) {},
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomButton(label: "Save", onTap: _updateProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
