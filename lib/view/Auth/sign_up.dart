// // ignore_for_file: unnecessary_import, use_build_context_synchronously, unused_field

// import 'package:birthdaycounter/controllers/AuthControllers/signup_controller.dart';
// import '../../controllers/AuthControllers/google_login_controller.dart';
// import 'package:birthdaycounter/widgets/custom_google_login.dart';
// import 'package:birthdaycounter/widgets/custom_form_field.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/Services/auth_service.dart';
// import 'package:birthdaycounter/widgets/custom_button.dart';
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/view/home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final SignupController _signupController = SignupController();
//   final GoogleLoginController _googleLoginController = GoogleLoginController();
//   final _loginkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _loginkey,
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Image.asset(
//                     "assets/login.png",
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned(
//                     top: 60,
//                     right: 0,
//                     child: Image.asset("assets/baloon.png", width: 70),
//                   ),
//                 ],
//               ),

//               Text(
//                 "Sign Up",
//                 style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Sign Up to create a new account.",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 20),

//               /// FULL NAME
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomFormField(
//                   label: "Enter your name",
//                   icon: Icons.person,
//                   controller: _signupController.fullNameController,
//                 ),
//               ),

//               SizedBox(height: 10),

//               /// EMAIL
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomFormField(
//                   label: "Enter your email",
//                   icon: Icons.email,
//                   controller: _signupController.emailController,
//                 ),
//               ),

//               SizedBox(height: 10),

//               /// PASSWORD
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomFormField(
//                   label: "Enter your password",
//                   icon: Icons.lock,
//                   suicon: Icons.visibility,
//                   controller: _signupController.passwordController,
//                   validation: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Password is required";
//                     }
//                     if (value.length < 8) {
//                       return "Password must be at least 8 characters";
//                     }
//                     return null;
//                   },
//                 ),
//               ),

//               SizedBox(height: 25),
//               CustomButton(
//                 label: "Signup",
//                 onTap: () async {
//                   final password = _signupController.passwordController.text
//                       .trim();

//                   //  Stop if password is less than 8 characters
//                   if (password.length < 8) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: AppColors.primary,
//                         content: Text(
//                           "Password must be at least 8 characters",
//                           style: TextStyle(color: AppColors.white),
//                         ),
//                       ),
//                     );
//                     return; // ⛔ DO NOT MOVE TO NEXT SCREEN
//                   }

//                   // 1️⃣ Signup user
//                   await _signupController.signup(context);

//                   final user = FirebaseAuth.instance.currentUser;

//                   // ❌ If signup failed, stay on same screen
//                   if (user == null) return;

//                   // 2️⃣ Save user data
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(user.uid)
//                       .set({
//                         'fullName': _signupController.fullNameController.text
//                             .trim(),
//                         'email': _signupController.emailController.text.trim(),
//                       });

//                   // 3️⃣ Move to HomeScreen ONLY if everything is OK
//                   Navigator.pushReplacement(
//                     context,
//                     PageRouteBuilder(
//                       transitionDuration: const Duration(milliseconds: 500),
//                       pageBuilder: (_, __, ___) => const HomeScreen(),
//                       transitionsBuilder: (_, animation, __, child) {
//                         return FadeTransition(opacity: animation, child: child);
//                       },
//                     ),
//                   );
//                 },
//               ),

//               SizedBox(height: 25),
//               Text(
//                 "-------- Or Signup with --------",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: AppColors.grey,
//                 ),
//               ),

//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomGoogleLogin(
//                   label: "Google",
//                   onTap: () async {
//                     debugPrint("🔹 Continue with Google button pressed");

//                     try {
//                       final user = await GoogleAuthService().signInWithGoogle();

//                       // 🔑 Final success check
//                       if (user != null &&
//                           FirebaseAuth.instance.currentUser != null) {
//                         debugPrint(
//                           "✅ Google Sign-In SUCCESS: ${FirebaseAuth.instance.currentUser!.email}",
//                         );

//                         // Move to HomeScreen
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (_) => const HomeScreen()),
//                         );
//                       } else {
//                         debugPrint("❌ Google Sign-In failed or user is null");
//                       }
//                     } catch (e) {
//                       debugPrint("❌ Google Sign-In Exception: $e");
//                     }
//                   },
//                 ),
//               ),

//               SizedBox(height: 25),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Have an account? ",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                   GestureDetector(
//                     onTap: () => Get.toNamed(AppRoutesName.login),
//                     child: Text(
//                       "Sign In",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                    top: 60,
                    right: 0,
                    child: Image.asset("assets/baloon.png", width: 70),
                  ),
                ],
              ),

              const Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign Up to create a new account.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              /// FULL NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  label: "Enter your name",
                  icon: Icons.person,
                  controller: _signupController.fullNameController,
                  validation: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please fill all fields";
                    }

                    if (value.length < 3 || value.length > 10) {
                      return "Name must be 3 to 10 words";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(height: 10),

              /// EMAIL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  label: "Enter your email",
                  icon: Icons.email,
                  controller: _signupController.emailController,
                  validation: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please fill all fields";
                    }

                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return "Enter a valid email address";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(height: 10),

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
                      return "Please fill all fields";
                    }

                    if (value.length < 8 || value.length > 20) {
                      return "Password must be 8–20 characters";
                    }

                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                      return "Password must contain 1 special character";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(height: 25),

              /// SIGNUP BUTTON
              CustomButton(
                label: "Signup",
                onTap: () async {
                  // 🔥 THIS triggers field-level errors
                  if (!_loginkey.currentState!.validate()) {
                    return;
                  }

                  // 1️⃣ Signup user
                  await _signupController.signup(context);

                  final user = FirebaseAuth.instance.currentUser;

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

                  // 3️⃣ Navigate
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

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or Signup with",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomGoogleLogin(
                  label: "Google",
                  onTap: () async {
                    try {
                      final user = await GoogleAuthService().signInWithGoogle();

                      if (user != null &&
                          FirebaseAuth.instance.currentUser != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    } catch (e) {
                      debugPrint("❌ Google Sign-In Exception: $e");
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
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
