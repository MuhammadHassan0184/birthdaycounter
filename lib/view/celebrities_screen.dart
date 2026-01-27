// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_actor_card.dart';
import 'package:birthdaycounter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CelebritiesScreen extends StatefulWidget {
  const CelebritiesScreen({super.key});

  @override
  State<CelebritiesScreen> createState() => _CelebritiesScreenState();
}

class _CelebritiesScreenState extends State<CelebritiesScreen> {
  String selectedChip = "All";
  List<String> chips = ["All", "Singers", "Actors", "Actresses"];

  String selectedChip2 = "All Celebrities";
  List<String> chip2 = ["All Celebrities", "Your Favorites"];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoutesName.homeScreen);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Celebrities",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),

            /// TOP CATEGORY CHIPS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: chips.map((chip) {
                    bool isSelected = selectedChip == chip;

                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedChip = chip;
                          });
                        },
                        child: Chip(
                          label: Text(
                            chip,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : AppColors.grey,
                            ),
                          ),
                          backgroundColor: isSelected
                              ? AppColors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: AppColors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 5),

            /// SEARCH + FAVORITE CHIPS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomSearchBar(
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: Wrap(
                      spacing: 20,
                      children: chip2.map((chip) {
                        bool isSelected = selectedChip2 == chip;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedChip2 = chip;
                            });
                          },
                          child: Chip(
                            label: Text(
                              chip,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.grey,
                              ),
                            ),
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: AppColors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 7),

            /// LISTVIEW Bulder
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return CustomActorCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
