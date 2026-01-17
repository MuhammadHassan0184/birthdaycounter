// import 'package:birthdaycounter/config/Routes/routes.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       // home: SplashScreen(),
//       getPages: AppRoutes.routes,
//       initialRoute: AppRoutesName.onboardingSlider,

//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       // getPages: AppRoutes.routes(),
//     );
//   }
// }

import 'package:birthdaycounter/config/Routes/routes.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
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
