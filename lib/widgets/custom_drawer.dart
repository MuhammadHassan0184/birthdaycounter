// ignore_for_file: deprecated_member_use, unnecessary_import

import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.asset("assets/bell.png"),
                SizedBox(width: 7),
                Text(
                  "Birthday Reminder",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 98,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.2)],
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
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.clean_hands_rounded, color: AppColors.primary),
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
            leading: Icon(Icons.support_agent_sharp, color: AppColors.primary),
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
            leading: Icon(Icons.policy, color: AppColors.primary),
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
            leading: Icon(Icons.share, color: AppColors.primary),
            title: Text("Share", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration_outlined,
              color: AppColors.primary,
            ),
            title: Text(
              "More Apps",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
