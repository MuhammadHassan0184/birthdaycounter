import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:birthdaycounter/config/Colors/colors.dart'; // make sure this is imported

// class SignupController {
//   final AuthService _authService = AuthService();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final fullNameController = TextEditingController();

//   bool isLoading = false;

//   Future<void> signup(BuildContext context) async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     final fullName = fullNameController.text.trim();

//     if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
//       _showSnack(context, "Please fill all fields.");
//       return;
//     }

//     try {
//       isLoading = true;

//       // Create user
//       User? user = await _authService.signUp(
//         email,
//         password,
//         fullName,
//       );

//       isLoading = false;

//       if (user != null) {
//         _showSnack(context, "Signup successful!");

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//         );
//       } else {
//         _showSnack(context, "Signup failed. Try again.");
//       }
//     } catch (e) {
//       isLoading = false;
//       _showSnack(context, e.toString());
//     }
//   }

//   void _showSnack(BuildContext context, String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           msg,
//           style: const TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.primary, // ✅ primary theme color
//       ),
//     );
//   }
// }

class SignupController {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  bool isLoading = false;

  Future<void> signup(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = fullNameController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      _showSnack(context, "Please fill all fields.");
      return;
    }

    try {
      isLoading = true;

      // Create user
      User? user = await _authService.signUp(
        email,
        password,
        fullName,
      );

      isLoading = false;

      if (user != null) {
        _showSnack(context, "Signup successful! Please login.");

        // ✅ Navigate to Login screen instead of HomeScreen
        Navigator.pushReplacementNamed(context, '/login'); 
        // Or if using GetX: Get.offAllNamed(AppRoutesName.login);
      } else {
        _showSnack(context, "Signup failed. Try again.");
      }
    } catch (e) {
      isLoading = false;
      _showSnack(context, e.toString());
    }
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

