// ignore_for_file: deprecated_member_use, unnecessary_import, use_build_context_synchronously

import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/bell.svg"),
                    SizedBox(width: 7),
                    Text(
                      "Birthday Reminder",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                height: 98,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.75, 2],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unlock to Pro",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Enjoy all benefits without\n any restrictions",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person, color: AppColors.primary),
                title: Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.toNamed(AppRoutesName.profileScreen);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/Celebrities.svg",
                  color: AppColors.primary,
                ),
                // Icon(Icons.clean_hands_rounded, color: AppColors.primary),
                title: Text(
                  "Celebrities",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.toNamed(AppRoutesName.celebritiesScreen);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/support.svg",
                  color: AppColors.primary,
                ),
                title: Text(
                  "Support",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: Icon(Icons.star, color: AppColors.primary),
                title: Text(
                  "Rate Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/privacy.svg",
                  color: AppColors.primary,
                ),
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.toNamed(AppRoutesName.privacyPolicy);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/share.svg",
                  color: AppColors.primary,
                ),
                title: Text(
                  "Share",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/moreapp.svg",
                  color: AppColors.primary,
                ),
                title: Text(
                  "More Apps",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  label: "Log Out",
                  onTap: () async {
                    // Show confirmation dialog
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.white, // your theme
                        title: Text(
                          "Confirm Logout",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        content: const Text(
                          "Are you sure you want to log out?",
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    // If user confirmed logout
                    if (confirm == true) {
                      // Firebase logout
                      await AuthService().logout();

                      // Navigate to login screen
                      Get.offNamed(AppRoutesName.login);

                      // Optional: show snackbar confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Logged out successfully"),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
