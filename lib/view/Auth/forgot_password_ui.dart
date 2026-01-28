import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/controllers/AuthControllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  final TextEditingController emailController;
  final ForgotPasswordController _controller = ForgotPasswordController();

  ForgotPasswordText({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.sendPasswordResetEmail(
          email: emailController.text,
          context: context,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Forgot Password?",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
