import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/Auth/forgot_password_screen.dart';
import 'package:birthdaycounter/view/Auth/login.dart';
import 'package:birthdaycounter/view/Auth/sign_up.dart';
import 'package:birthdaycounter/view/Onboarding/slider/OnboardingSlider.dart';
import 'package:birthdaycounter/view/add_reminder.dart';
import 'package:birthdaycounter/view/celebrities_screen.dart';
import 'package:birthdaycounter/view/celebrity_preview.dart';
import 'package:birthdaycounter/view/home_screen.dart';
import 'package:birthdaycounter/view/preview_reminder.dart';
import 'package:birthdaycounter/view/privacy_policy.dart';
import 'package:birthdaycounter/view/profile_screen.dart';
import 'package:birthdaycounter/view/splash/splash_screen.dart';
import 'package:birthdaycounter/view/wishes_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutesName.onboardingSlider,
      page: () => OnboardingSlider(),
    ),
    GetPage(
      name: AppRoutesName.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutesName.signup,
      page: () => SignUp(),
    ),
    GetPage(
      name: AppRoutesName.login,
      page: () => Login(),
    ),
    GetPage(
      name: AppRoutesName.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutesName.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutesName.addReminder,
      page: () => AddReminder(),
    ),
    GetPage(
      name: AppRoutesName.wishesScreen,
      page: () => WishesScreen(),
    ),
    GetPage(
      name: AppRoutesName.previewReminder,
      page: () => PreviewReminder(),
    ),
    GetPage(
      name: AppRoutesName.celebritiesScreen,
      page: () => CelebritiesScreen(),
    ),
    GetPage(
      name: AppRoutesName.celebrityPreview,
      page: () => CelebrityPreview(),
    ),
    GetPage(
      name: AppRoutesName.privacyPolicy,
      page: () => PrivacyPolicy(),
    ),
    GetPage(
      name: AppRoutesName.profileScreen,
      page: () => ProfileScreen(),
    ),
  ];
}
