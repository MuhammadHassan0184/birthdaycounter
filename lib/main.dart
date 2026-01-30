// // ignore_for_file: avoid_print

// import 'package:birthdaycounter/Services/notification_service.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/view/splash/splash_screen.dart';
// import 'package:birthdaycounter/config/Routes/routes.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:birthdaycounter/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter/material.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   print("Starting Firebase init...");

//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print("Firebase initialized SUCCESSFULLY!");
//   } catch (e) {
//     print("Firebase Init Error: $e");
//   }
//   await NotificationService.init(); // 🔥 REQUIRED

//   // Set default Firebase Auth language
//   FirebaseAuth.instance.setLanguageCode('en');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       navigatorKey: navigatorKey, // 👈 REQUIRED

//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         fontFamily: 'Poppins',
//         textTheme: GoogleFonts.poppinsTextTheme(),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const SplashWrapper(), // show splash first
//       getPages: AppRoutes.routes,
//     );
//   }
// }

// // A wrapper to handle splash delay
// class SplashWrapper extends StatefulWidget {
//   const SplashWrapper({super.key});

//   @override
//   State<SplashWrapper> createState() => _SplashWrapperState();
// }

// class _SplashWrapperState extends State<SplashWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     // Delay 3 seconds then go to onboarding
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.offNamed(AppRoutesName.onboardingSlider); // navigate after splash
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SplashScreen();
//   }
// }

// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:birthdaycounter/Services/notification_service.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/splash/splash_screen.dart';
import 'package:birthdaycounter/config/Routes/routes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:birthdaycounter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Starting Firebase init...");

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized SUCCESSFULLY!");
  } catch (e) {
    print("Firebase Init Error: $e");
  }

  await NotificationService.init(); // 🔥 REQUIRED

  // Get payload if app was launched from notification
  final String? initialPayload = await NotificationService.getInitialPayload();

  // Set default Firebase Auth language
  FirebaseAuth.instance.setLanguageCode('en');

  runApp(MyApp(initialPayload: initialPayload));
}

class MyApp extends StatelessWidget {
  final String? initialPayload;
  const MyApp({super.key, this.initialPayload});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Birthday Reminder',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashWrapper(initialPayload: initialPayload),
      getPages: AppRoutes.routes,
    );
  }
}

/// A wrapper to handle splash delay + notification payload
class SplashWrapper extends StatefulWidget {
  final String? initialPayload;
  const SplashWrapper({super.key, this.initialPayload});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      _handleNavigation();
    });
  }

  void _handleNavigation() {
    // If app was opened via notification, go to PreviewReminder
    if (widget.initialPayload != null && widget.initialPayload!.isNotEmpty) {
      try {
        final Map<String, dynamic> reminderData = jsonDecode(
          widget.initialPayload!,
        );
        Get.offNamed(AppRoutesName.previewReminder, arguments: reminderData);
        return;
      } catch (e) {
        print("Error decoding initial payload: $e");
      }
    }

    // Otherwise, navigate based on login status
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAllNamed(AppRoutesName.homeScreen);
    } else {
      Get.offAllNamed(AppRoutesName.onboardingSlider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
