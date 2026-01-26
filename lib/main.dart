// ignore_for_file: avoid_print

import 'package:birthdaycounter/Services/notification_service.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/splash/splash_screen.dart';
import 'package:birthdaycounter/config/Routes/routes.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:birthdaycounter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashWrapper(), // show splash first
      getPages: AppRoutes.routes,
    );
  }
}

// A wrapper to handle splash delay
class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    // Delay 3 seconds then go to onboarding
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutesName.onboardingSlider); // navigate after splash
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
