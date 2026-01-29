import 'package:birthdaycounter/controllers/AuthControllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/Custom_Secondry_Field.dart';
import '../../widgets/custom_button.dart';
import '../../config/Colors/colors.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            Text(
              "Forgot Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "Enter your email and we’ll send you a password reset link.",
              style: TextStyle(color: AppColors.grey),
            ),

            SizedBox(height: 30),

            CustomSecondryField(
              label: "Email",
              icon: Icons.email,
              controller: controller.emailController,
            ),

            SizedBox(height: 35),

            Obx(
              () => CustomButton(
                title: controller.loading.value
                    ? "Sending..."
                    : "Reset Password",
                onTap: controller.sendResetLink,
                label: 'Reset Password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
