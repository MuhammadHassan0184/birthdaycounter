// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomActorCard extends StatefulWidget {
  const CustomActorCard({super.key});

  @override
  State<CustomActorCard> createState() => _CustomActorCardState();
}

class _CustomActorCardState extends State<CustomActorCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutesName.celebrityPreview);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            /// FAVORITE ICON
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppColors.primary : AppColors.primary,
                size: 22,
              ),
            ),
      
            SizedBox(width: 10),
      
            /// IMAGE
            Container(
              width: 55,
              height: 55,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset("assets/imagei.png", fit: BoxFit.cover),
            ),
      
            SizedBox(width: 12),
      
            /// TEXT SECTION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Muhammad Hassan",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
      
                  SizedBox(height: 4),
      
                  Text(
                    "06-11-2006",
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
      
                  SizedBox(height: 4),
      
                  Row(
                    children: [
                      Text(
                        "Birthday ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "(287 Days)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
