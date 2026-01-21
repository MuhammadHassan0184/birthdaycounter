// ignore_for_file: unnecessary_import, use_build_context_synchronously

import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/AuthControllers/signup_controller.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/widgets/custom_form_field.dart';
import 'package:birthdaycounter/widgets/custom_google_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/AuthControllers/google_login_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignupController _signupController = SignupController();
 final GoogleLoginController _googleLoginController = GoogleLoginController();
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
              ),
            ),

            SizedBox(height: 25),

            /// SIGNUP BUTTON
            CustomButton(
              label: "Signup",
              onTap: () async {
                await _signupController.signup(context);

                // ✅ Navigate only if signup is successful
                if (_signupController.isLoading == false &&
                    _signupController.emailController.text.isNotEmpty &&
                    _signupController.passwordController.text.isNotEmpty) {
                  // Smooth navigation using PageRouteBuilder
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(
                        milliseconds: 500,
                      ), // animation duration
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        // Fade transition
                        return FadeTransition(opacity: animation, child: child);

                        // Or slide transition from right
                        // return SlideTransition(
                        //   position: Tween<Offset>(
                        //     begin: const Offset(1, 0),
                        //     end: Offset.zero,
                        //   ).animate(animation),
                        //   child: child,
                        // );
                      },
                    ),
                  );
                }
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
    );
  }
}
