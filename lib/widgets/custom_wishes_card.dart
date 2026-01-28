// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- for Clipboard

class CustomWishesCard extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback? onAdd;

  const CustomWishesCard({
    super.key,
    required this.label,
    this.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac lectus luctus, consectetur nisi vitae, ultrices metust.",
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final String fullText = "$label\n$description";

    return GestureDetector(
      onTap: () {
        // Show popup dialog with full wish
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(child: Text(description)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Close", style: TextStyle(color: AppColors.white)),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
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
                  const SizedBox(height: 4),
                  Text(
                    description,
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
              color: AppColors.grey.withOpacity(0.2),
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),

            // Icons Section
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: fullText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        content: Row(
                          children: const [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
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
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.copy, color: AppColors.black),
                ),
                IconButton(
                  onPressed: onAdd ?? () {},
                  icon: Icon(Icons.add, color: AppColors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
