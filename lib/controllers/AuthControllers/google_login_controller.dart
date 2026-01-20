import 'package:birthdaycounter/services/auth_service.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:flutter/material.dart';

class GoogleLoginController {
  /// Handles Google Sign-In
  Future<void> signInWithGoogle(BuildContext context) async {
    final user = await AuthService().signInWithGoogle();

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Google Sign-In canceled or failed"),
        ),
      );
    }
  }
}
