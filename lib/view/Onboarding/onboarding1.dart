// // ignore_for_file: unnecessary_string_escapes, sized_box_for_whitespace
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class Onboarding1 extends StatelessWidget {
//   const Onboarding1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Image.asset(
//                   "assets/onboard1svg.png",
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   width: 300,
//                   height: 270,
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 300, // specify height
//                     child: SvgPicture.asset(
//                       "assets/onboarding1.svg",
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
// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                "assets/onboard1svg.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              /// This makes content center vertically
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/onboarding1.svg",
                      width: 300,
                      height: 270,
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
