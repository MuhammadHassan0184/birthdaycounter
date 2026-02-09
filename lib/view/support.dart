// // ignore_for_file: deprecated_member_use

// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Support extends StatelessWidget {
//   Support({super.key});

//   // Controllers
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();

//   // ================= SEND EMAIL USING MAILTO (FIXED) =================
//   Future<void> sendSupportEmail() async {
//     final String name = nameController.text.trim();
//     final String email = emailController.text.trim();
//     final String message = messageController.text.trim();

//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: 'info@thewebconcept.com',
//       queryParameters: {
//         'subject': 'Support Message',
//         'body':
//             'Name: $name\n'
//             'Email: $email\n\n'
//             'Message:\n$message',
//       },
//     );

//     try {
//       await launchUrl(emailUri, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "No email app found to send message",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   // ================= INPUT DECORATION =================
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: AppColors.bggrey.withOpacity(0.2),
//       hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
//       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.black.withOpacity(0.1)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.black.withOpacity(0.1)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(
//           color: AppColors.primary.withOpacity(0.6),
//           width: 1,
//         ),
//       ),
//     );
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         leading: IconButton(
//           onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
//           icon: Icon(Icons.arrow_back, color: AppColors.white),
//         ),
//         title: Text(
//           "Support",
//           style: TextStyle(
//             color: AppColors.white,
//             fontWeight: FontWeight.w400,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             // Name
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 controller: nameController,
//                 decoration: _inputDecoration("Name"),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Email
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: _inputDecoration("Email"),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Message
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 controller: messageController,
//                 maxLines: 6,
//                 decoration: _inputDecoration("Message..."),
//               ),
//             ),

//             const SizedBox(height: 25),

//             // Send Button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: CustomButton(
//                 label: "Send",
//                 title: "",
//                 onTap: () {
//                   if (nameController.text.isEmpty ||
//                       emailController.text.isEmpty ||
//                       messageController.text.isEmpty) {
//                     Get.snackbar(
//                       "Error",
//                       "All fields are required",
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.red,
//                       colorText: Colors.white,
//                     );
//                   } else {
//                     sendSupportEmail();
//                   }
//                 },
//               ),
//             ),

//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  Support({super.key});

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // ================= CLEAR ALL FIELDS =================
  void _clearFields() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  // ================= SEND EMAIL =================
  Future<void> sendSupportEmail() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String message = messageController.text.trim();

    final String body = '''
Name: $name
Email: $email

Message:
$message
''';

    final String encodedBody =
        Uri.encodeComponent(body).replaceAll('+', '%20');

    final String encodedSubject =
        Uri.encodeComponent('Contact Form').replaceAll('+', '%20');

    final Uri emailUri = Uri.parse(
      'mailto:info@thewebconcept.com'
      '?subject=$encodedSubject'
      '&body=$encodedBody',
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      // ✅ Clear fields when user returns to app
      _clearFields();

    } catch (e) {
      Get.snackbar(
        "Error",
        "No email app found to send message",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
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

            // Message
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
