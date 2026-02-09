// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String label;
//   final VoidCallback? onTap;

//   const CustomButton({
//     super.key,
//     required this.label,
//     this.onTap,
//     required String title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: SizedBox(
//         height: 51,
//         width: double.infinity,
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.primary.withOpacity(0.4), // light purple
//                 AppColors.primary, // dark purple
//               ],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             borderRadius: BorderRadius.circular(40), // pill shape
//           ),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.zero,
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//             onPressed: onTap,
//             child: Center(
//               // ⭐ THIS IS THE KEY
//               child: Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),

//           // ElevatedButton(
//           //   style: ElevatedButton.styleFrom(
//           //     padding: EdgeInsets.zero, // ✅ FIX (THIS IS REQUIRED)
//           //     backgroundColor: Colors.transparent,
//           //     shadowColor: Colors.transparent,
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(30),
//           //     ),
//           //   ),
//           //   onPressed: onTap,
//           //   child: Text(
//           //     label,
//           //     style: const TextStyle(
//           //       color: Colors.white,
//           //       fontWeight: FontWeight.w600,
//           //       fontSize: 18,
//           //        height: 1.0, // ✅ optional but recommended
//           //     ),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }
// }
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    required String title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 51,
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.4),
                    AppColors.primary,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                // ✅ removed const
                child: Text(
                  label, // ✅ now works
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
