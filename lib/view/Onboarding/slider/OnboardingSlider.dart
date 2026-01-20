// ignore_for_file: deprecated_member_use, unnecessary_import, file_names

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/view/Onboarding/onboarding1.dart';
import 'package:birthdaycounter/view/Onboarding/onboarding2.dart';
import 'package:birthdaycounter/view/Onboarding/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardingSlider extends StatefulWidget {
  const OnboardingSlider({super.key});

  @override
  State<OnboardingSlider> createState() => _OnboardingSliderState();
}

class _OnboardingSliderState extends State<OnboardingSlider> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Widget> pages = [Onboarding1(), Onboarding2(), Onboarding3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView(
          //   controller: _controller,
          //   children: pages,
          //   onPageChanged: (index) {
          //     setState(() => currentIndex = index);
          //   },
          // ),
          PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(), // Disable swipe
            children: pages,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
          ),

          /// NEXT / BACK BUTTONS + DOTS IN ONE ROW
          Positioned(
            left: 50,
            right: 20,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// BACK BUTTON
                if (currentIndex > 0)
                  Container(
                    padding: EdgeInsets.only(left: 6),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  )
                else
                  SizedBox(width: 36),

                /// DOTS INDICATOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 10,
                      width: currentIndex == index ? 18 : 10,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                /// NEXT / CONTINUE BUTTON
                GestureDetector(
                  onTap: () {
                    if (currentIndex == pages.length - 1) {
                      Get.toNamed(AppRoutesName.signup);
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },

                  child: Container(
                    width: 90,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentIndex == pages.length - 1
                              ? "Continue"
                              : "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (currentIndex != pages.length - 1) ...[
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_right, color: Colors.white),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
