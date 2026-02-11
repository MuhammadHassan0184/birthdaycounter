// // ignore_for_file: use_build_context_synchronously

// import 'package:birthdaycounter/Services/auth_service.dart';
// import 'package:birthdaycounter/view/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginController {
//   final AuthService _authService = AuthService();

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Future<void> login(BuildContext context) async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text(
//             "Please fill all fields",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.primary,
//         ),
//       );
//       return;
//     }

//     try {
//       // Firebase login
//       final userCredential = await _authService.login(email, password);

//       if (userCredential.user != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "Welcome ${userCredential.user!.email}",
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: AppColors.primary,
//           ),
//         );

//         // Navigate to HomeScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       // Map Firebase error codes to friendly messages
//       String message = "Login failed. Please try again.";

//       if (e.code == 'user-not-found') {
//         message = "No account found for this email.";
//       } else if (e.code == 'wrong-password') {
//         message = "Incorrect password. Please try again.";
//       } else if (e.code == 'invalid-email') {
//         message = "The email address is invalid.";
//       } else if (e.code == 'user-disabled') {
//         message = "This account has been disabled.";
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message, style: const TextStyle(color: Colors.white)),
//           backgroundColor: AppColors.primary,
//         ),
//       );
//     } catch (e) {
//       // Any other errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text(
//             "Something went wrong. Please try again.",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.primary,
//         ),
//       );
//       debugPrint("Login Exception: $e");
//     }
//   }
// }
// ignore_for_file: use_build_context_synchronously

import 'package:birthdaycounter/Services/auth_service.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnack(context, "Please fill all fields");
      return;
    }

    try {
      final userCredential = await _authService.login(email, password);

      if (userCredential.user != null) {
        _showSnack(context, "Welcome ${userCredential.user!.email}");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login failed. Please try again.";

      switch (e.code) {
        case 'user-not-found':
          message = "No account found for this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          message = "The email address is invalid.";
          break;
        case 'user-disabled':
          message = "This account has been disabled.";
          break;
      }

      _showSnack(context, message);
    } catch (e) {
      _showSnack(context, "Something went wrong. Please try again.");
      debugPrint("Login Exception: $e");
    }
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
