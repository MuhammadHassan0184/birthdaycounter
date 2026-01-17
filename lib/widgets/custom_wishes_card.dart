import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomWishesCard extends StatelessWidget {
  final String label;
  const CustomWishesCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            constraints: const BoxConstraints(
              // maxHeight: 91, // Max height
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
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
                          fontSize: 18
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac lectus luctus, consectetur nisi vitae, ultrices metust.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                        softWrap: true,
                        overflow: TextOverflow
                            .ellipsis, // Show ... if exceeds max height
                        maxLines: 3, // Limit lines to 3
                      ),
                    ],
                  ),
                ),

                // Vertical Divider
                Container(
                  height: 60, // Adjust to match content height
                  width: 1,
                  color: AppColors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),

                // Icons Section
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add,)),
                  ],
                ),
              ],
            ),
          );
  }
}