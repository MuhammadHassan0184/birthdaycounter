import 'package:birthdaycounter/config/Routes/routes.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/Auth/sign_up.dart';
import 'package:birthdaycounter/view/Onboarding/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      // home: SplashScreen(),
      // home: Onboarding1(),
      // home: Onboarding2(),
      // home: Onboarding3(),
      // home: OnboardingSlider(),
      // home: Login(),
      // home: SignUp(),

       getPages: AppRoutes.routes(),
       initialRoute: AppRoutesName.onboardingSlider,


      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // getPages: AppRoutes.routes(),
    );
  }
}

