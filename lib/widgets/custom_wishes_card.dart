// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- import this for Clipboard

class CustomWishesCard extends StatelessWidget {
  final String label;
  const CustomWishesCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    // Combine your label and description text
    final String fullText =
        "$label\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac lectus luctus, consectetur nisi vitae, ultrices metust.";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      constraints: const BoxConstraints(
        // maxHeight: 91, // Max height
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac lectus luctus, consectetur nisi vitae, ultrices metust.",
                  style: TextStyle(fontWeight: FontWeight.w400),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(
            height: 60,
            width: 1,
            color: AppColors.grey.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),

          // Icons Section
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: fullText));

                  // Professional themed SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior
                          .floating, // Makes it float above the UI
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      backgroundColor:
                          AppColors.primary, // Your theme primary color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Copied to clipboard",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      duration:  Duration(
                        seconds: 2,
                      ), // Auto dismiss after 2 seconds
                    ),
                  );
                },
                icon: Icon(Icons.copy),
              ),

              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
        ],
      ),
    );
  }
}
