
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/Auth/login.dart';
import 'package:birthdaycounter/view/Auth/sign_up.dart';
import 'package:birthdaycounter/view/Onboarding/slider/OnboardingSlider.dart';
import 'package:birthdaycounter/view/add_reminder.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static routes() => [
    GetPage(name: AppRoutesName.onboardingSlider, page: ()=> OnboardingSlider()),
    GetPage(name: AppRoutesName.signup, page: ()=> SignUp()),
    GetPage(name: AppRoutesName.login, page: ()=> Login()),
    GetPage(name: AppRoutesName.homeScreen, page: ()=> HomeScreen()),
    GetPage(name: AppRoutesName.addReminder, page: ()=> AddReminder()),
  ];
}