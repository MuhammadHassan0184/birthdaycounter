import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_wishes_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class WishesScreen extends StatefulWidget {
  const WishesScreen({super.key});

  @override
  State<WishesScreen> createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  String selectedChip = "All"; // default selected
  List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoutesName.homeScreen);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Wishes",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            // chip
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: chips.map((chip) {
                    bool isSelected = selectedChip == chip;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                              color: isSelected ? Colors.white : AppColors.grey,
                            ),
                          ),
                          backgroundColor: isSelected
                              ? AppColors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: AppColors.grey, width: 1),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 15),
            // wishescard
           Expanded(
             child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index){
              return CustomWishesCard(label: "Birthday");
             }),
           ),
           SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
