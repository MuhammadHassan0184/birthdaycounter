// ignore_for_file: unnecessary_import, use_build_context_synchronously, unused_field

import 'package:birthdaycounter/controllers/AuthControllers/signup_controller.dart';
import '../../controllers/AuthControllers/google_login_controller.dart';
import 'package:birthdaycounter/widgets/custom_google_login.dart';
import 'package:birthdaycounter/widgets/custom_form_field.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignupController _signupController = SignupController();
  final GoogleLoginController _googleLoginController = GoogleLoginController();
  final _loginkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _loginkey,
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
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                "Sign Up to create a new account.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),

              /// FULL NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  label: "Enter your name",
                  icon: Icons.person,
                  controller: _signupController.fullNameController,
                ),
              ),

              SizedBox(height: 10),

              /// EMAIL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  label: "Enter your email",
                  icon: Icons.email,
                  controller: _signupController.emailController,
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
                  controller: _signupController.passwordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 25),
              CustomButton(
                label: "Signup",
                onTap: () async {
                  final password = _signupController.passwordController.text
                      .trim();

                  //  Stop if password is less than 8 characters
                  if (password.length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.primary,
                        content: Text(
                          "Password must be at least 8 characters",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                    return; // ⛔ DO NOT MOVE TO NEXT SCREEN
                  }

                  // 1️⃣ Signup user
                  await _signupController.signup(context);

                  final user = FirebaseAuth.instance.currentUser;

                  // ❌ If signup failed, stay on same screen
                  if (user == null) return;

                  // 2️⃣ Save user data
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set({
                        'fullName': _signupController.fullNameController.text
                            .trim(),
                        'email': _signupController.emailController.text.trim(),
                      });

                  // 3️⃣ Move to HomeScreen ONLY if everything is OK
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 25),
              Text(
                "-------- Or Signup with --------",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    "Have an account? ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutesName.login),
                    child: Text(
                      "Sign In",
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
      ),
    );
  }
}
