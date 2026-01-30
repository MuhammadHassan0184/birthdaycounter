// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:get/get.dart';

class Support extends StatelessWidget {
  Support({super.key});

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // ================= SEND EMAIL USING SMTP =================
  Future<void> sendSupportEmail() async {
    final String username = 'your_email@gmail.com'; // sender email
    final String password = 'your_app_password'; // Gmail App Password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Support App')
      ..recipients.add('info@thewebconcept.com') // your support email
      ..subject = 'Support Message'
      ..text =
          '''
Name: ${nameController.text}
Email: ${emailController.text}

Message:
${messageController.text}
''';

    try {
      await send(message, smtpServer);
      Get.snackbar(
        "Success",
        "Message sent successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      nameController.clear();
      emailController.clear();
      messageController.clear();
    } on MailerException catch (e) {
      Get.snackbar(
        "Error",
        "Message failed to send: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 6),
      );
    }
  }

  // ================= INPUT DECORATION =================
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.bggrey.withOpacity(0.2),
      hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.black.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.black.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.primary.withOpacity(0.6),
          width: 1,
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Support",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nameController,
                decoration: _inputDecoration("Name"),
              ),
            ),

            const SizedBox(height: 15),

            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration("Email"),
              ),
            ),

            const SizedBox(height: 15),

            // Message (MULTILINE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: messageController,
                maxLines: 6,
                decoration: _inputDecoration("Message..."),
              ),
            ),

            const SizedBox(height: 25),

            // Send Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                label: "Send",
                title: "",
                onTap: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      messageController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "All fields are required",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    sendSupportEmail();
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
