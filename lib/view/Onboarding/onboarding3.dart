// // ignore_for_file: sized_box_for_whitespace

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class Onboarding3 extends StatelessWidget {
//   const Onboarding3({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Image.asset(
//                   "assets/onboardingn3.png",
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   width: 270,
//                   height: 250,
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 300, // specify height
//                     child: SvgPicture.asset(
//                       "assets/onboard3.svg",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
                
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Text(
//                     "Never forget a birthday that matters.",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                "assets/onboardingn3.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              /// This centers content vertically
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/onboard3.svg",
                      width: 270,
                      height: 250,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Never forget a birthday that matters.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
