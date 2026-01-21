// ignore_for_file: unnecessary_import, use_build_context_synchronously

import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/AuthControllers/login_controller.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/widgets/custom_form_field.dart';
import 'package:birthdaycounter/widgets/custom_google_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _loginController = LoginController();

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
                Positioned(
                  top: 50,
                  right: 0,
                  child: Image.asset("assets/baloon.png", width: 120),
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

            /// EMAIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomFormField(
                label: "Enter your email",
                icon: Icons.email,
                controller: _loginController.emailController,
              ),
            ),

            SizedBox(height: 10),

            /// PASSWORD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomFormField(
                label: "Enter your password",
                icon: Icons.lock,
                suicon: Icons.visibility,
                controller: _loginController.passwordController,
              ),
            ),

            SizedBox(height: 25),

            /// LOGIN BUTTON
            CustomButton(
              label: "Login",
              onTap: () => _loginController.login(context),
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
              child: CustomGoogleLogin(
                label: "Google",
                onTap: () async {
                  debugPrint("🔹 Continue with Google button pressed");

                  try {
                    final user = await GoogleAuthService().signInWithGoogle();

                    // 🔑 Final success check
                    if (user != null &&
                        FirebaseAuth.instance.currentUser != null) {
                      debugPrint(
                        "✅ Google Sign-In SUCCESS: ${FirebaseAuth.instance.currentUser!.email}",
                      );

                      // Move to HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } else {
                      debugPrint("❌ Google Sign-In failed or user is null");
                    }
                  } catch (e) {
                    debugPrint("❌ Google Sign-In Exception: $e");
                  }
                },
              ),
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
                  onTap: () => Get.toNamed(AppRoutesName.signup),
                  child: Text(
                    "Sign Up",
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
