import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoutesName.homeScreen);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '''
      Privacy Policy:
      Last updated: 1 January 2026
      Your privacy is important to us. This Privacy Policy explains how we collect, use, store and protect your information when you use the Birthday Reminder mobile application (“App”).
      
      By using this App, you agree to the collection and use of information in accordance with this Privacy Policy.
      
      1. Information We Collect
      We collect information only to provide and improve the functionality of the App.
      
      a. Personal Information You Provide
      When using the App, you may voluntarily provide:
      - Names of contacts
      - Relationship details
      - Birthdays, anniversaries, and engagement dates
      - Optional phone numbers and email addresses
      - Custom wish messages
      
      This information is used only to manage reminders and notifications.
      
      b. Automatically Collected Information
      We may collect limited non-personal information such as:
      - Device type and operating system
      - App usage data (for performance and improvement)
      - Crash logs and analytics data
      
      This data does not identify you personally.
      
      2. How We Use Your Information
      We use the collected information to:
      - Create and manage birthday and event reminders
      - Send timely notifications
      - Display countdowns and event previews
      - Improve app performance and user experience
      - Provide customer support
      - Manage Pro subscription features
      
      We do not sell, rent, or trade your personal information.
      
      3. Notifications & Reminders
      The App uses notifications to remind you of upcoming events. You can enable or disable notifications at any time through your device settings.
      
      4. Celebrity Information
      Celebrity data shown in the App is for informational and entertainment purposes only and does not contain any personal user data.
      
      5. Data Storage & Security
      - Your data is stored securely on your device and/or secure servers.
      - We implement reasonable technical and organizational measures to protect your information.
      - No method of electronic storage is 100% secure, but we strive to protect your data.
      
      6. Third-Party Services
      The App may use trusted third-party services for:
      - Analytics
      - App performance monitoring
      - Subscription management
      
      These services may collect information according to their own privacy policies, and we recommend reviewing them.
      
      7. Pro Subscription
      If you choose to unlock Pro features:
      - Payments are processed securely through the App Store or Play Store.
      - We do not store your payment or card details.
      
      8. Children’s Privacy
      This App is not intended for children under the age of 13. We do not knowingly collect personal information from children. If you believe a child has provided personal data, please contact us so we can remove it.
      
      9. Your Rights
      You have the right to:
      - Access your personal data
      - Edit or delete reminders at any time
      - Uninstall the App to remove stored data from your device
      
      10. Changes to This Privacy Policy
      We may update this Privacy Policy from time to time. Any changes will be posted within the App, and the updated text will be available above.
      
      11. Contact Us
      If you have any questions or concerns about this Privacy Policy, please contact us:
      
      Email: info@thewebconcept.com
          ''',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
