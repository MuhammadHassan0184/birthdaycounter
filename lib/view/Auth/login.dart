// ignore_for_file: unnecessary_import

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/widgets/custom_form_field.dart';
import 'package:birthdaycounter/widgets/custom_google_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/login.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Balloon image positioned like the design
                Positioned(
                  top: 50,
                  right: 0,
                  child: Image.asset(
                    "assets/baloon.png",
                    width: 120, // adjust if needed
                  ),
                ),
              ],
            ),

            Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              "Sign In to access your profile.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            // enter your email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomFormField(
                label: "Enter your email",
                icon: Icons.email,
              ),
            ),
            SizedBox(height: 10),
            // enter your password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomFormField(
                label: "Enter your password",
                icon: Icons.lock,
                suicon: Icons.visibility,
              ),
            ),
            SizedBox(height: 10),
            // forget password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            // login button
            CustomButton(
              label: "Login",
              onTap: () {
                Get.offAllNamed(AppRoutesName.homeScreen);
              },
            ),
            SizedBox(height: 25),
            Text(
              "-------- Or Signin with --------",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // google login
              child: CustomGoogleLogin(label: "Google"),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account? ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutesName.signup);
                  },
                  child: Text(
                    "Sign Up ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
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
