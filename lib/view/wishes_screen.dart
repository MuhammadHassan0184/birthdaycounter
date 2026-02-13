// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/widgets/custom_wishes_card.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishesScreen extends StatefulWidget {
  const WishesScreen({super.key});

  @override
  State<WishesScreen> createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  final ReminderController reminderCtrl = Get.find<ReminderController>();

  String selectedChip = "All";
  final List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];

  // /// ✅ Default wishes by type
  // final Map<String, List<String>> defaultWishes = {
  //   "Birthday": [
  //     "Happy Birthday! 🎉 Wishing you a day full of joy and laughter.",
  //     "May your birthday bring you success, happiness, and good health 🎂",
  //     "Another year older, another year more amazing 🎈",
  //   ],
  //   "Anniversary": [
  //     "Happy Anniversary! 💖 Wishing you many more years of love.",
  //     "Cheers to another beautiful year together 🥂",
  //     "Your love story keeps getting better every year 💍",
  //   ],
  //   "Engagement": [
  //     "Congratulations on your engagement! 💍",
  //     "Wishing you a lifetime of love and happiness 💖",
  //     "So happy for you both on your engagement ✨",
  //   ],
  // };
  /// ✅ Default wishes by type (15+ each)
  final Map<String, List<String>> defaultWishes = {
    "Birthday": [
      "Happy Birthday! 🎉 Wishing you a day full of joy and laughter.",
      "May your birthday bring you success, happiness, and good health 🎂",
      "Another year older, another year more amazing 🎈",
      "Wishing you endless happiness on your special day 🎁",
      "May all your dreams come true this year 🌟",
      "Cheers to you and the wonderful life ahead 🥳",
      "Hope your birthday is as special as you are 💖",
      "Sending you smiles for every moment of your day 😊",
      "May this year bring new adventures and success 🚀",
      "Have a fantastic birthday filled with blessings 🙌",
      "Stay blessed and keep shining always ✨",
      "Wishing you love, laughter, and cake today 🍰",
      "Another year, another blessing 🎊",
      "May happiness surround you today and always 🌸",
      "Celebrate big and enjoy every second 🎶",
      "May your birthday be filled with peace and prosperity 🎂",
      "Wishing you strength, success, and smiles always 💪",
      "May this year bring new opportunities your way 🌈",
      "Enjoy your special day to the fullest 🎊",
      "Wishing you good health and great achievements 🏆",
      "May your life be full of positive vibes ✨",
      "Keep inspiring everyone around you 🌟",
      "Hope your birthday is full of sweet surprises 🍫",
      "May happiness follow you everywhere 🎈",
      "Have a joyful and memorable birthday celebration 🎉",
    ],

    "Anniversary": [
      "Happy Anniversary! 💖 Wishing you many more years of love.",
      "Cheers to another beautiful year together 🥂",
      "Your love story keeps getting better every year 💍",
      "May your bond grow stronger every day ❤️",
      "Celebrating the love you both share today 💑",
      "Wishing you joy, love, and togetherness forever 🌹",
      "Another year of wonderful memories 💫",
      "May your love continue to shine brightly ✨",
      "Together is a beautiful place to be 💞",
      "Happy Anniversary to a perfect pair 👩‍❤️‍👨",
      "Your journey together is inspiring 🌷",
      "Love grows deeper with every passing year 🌺",
      "May you always stand by each other 🤝",
      "Best wishes on your special milestone 🎉",
      "Forever looks beautiful on you both 💎",
      "Wishing you a lifetime of beautiful moments together 💕",
      "Happy Anniversary! Stay blessed always 🙏",
      "May your love story never end 💖",
      "Another year of love and laughter 🥰",
      "May your marriage be filled with endless joy 🌹",
      "Together forever, stronger than ever 💑",
      "Your love is truly inspiring 🌟",
      "May your hearts beat as one forever ❤️",
      "Celebrating your everlasting bond 🎊",
      "Wishing you many more happy years together 🥂",
    ],

    "Engagement": [
      "Congratulations on your engagement! 💍",
      "Wishing you a lifetime of love and happiness 💖",
      "So happy for you both on your engagement ✨",
      "May your love story be magical and charming 🏰",
      "Cheers to your new beginning together 🥂",
      "A beautiful journey is about to begin 💑",
      "Wishing you joy and laughter always 😊",
      "May your hearts stay forever connected ❤️",
      "Engagement is just the beginning of forever 💞",
      "Congratulations on finding your forever person 💎",
      "May your bond grow stronger every day 🌹",
      "Wishing you endless love and happiness 🌸",
      "So excited for your future together 🎊",
      "May your love shine brighter with time 🌟",
      "Best wishes on your engagement celebration 🎉",
      "Congratulations on this beautiful commitment 💍",
      "May your future be full of happiness 🌸",
      "Wishing you both a joyful life ahead 💖",
      "Your journey of love begins today 🌟",
      "May your engagement be the start of forever 💕",
      "Best wishes for your new chapter 📖",
      "So thrilled for your happy news 🎉",
      "May your dreams come true together 🌈",
      "Wishing you harmony and love always ❤️",
      "Cheers to your exciting future together 🥂",
    ],
  };

  @override
  Widget build(BuildContext context) {
    /// ✅ Build filtered wish list
    final List<Map<String, String>> wishes = selectedChip == "All"
        ? defaultWishes.entries
              .expand(
                (entry) => entry.value.map(
                  (wish) => {"type": entry.key, "wish": wish},
                ),
              )
              .toList()
        : defaultWishes[selectedChip]!
              .map((wish) => {"type": selectedChip, "wish": wish})
              .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.offNamed(AppRoutesName.homeScreen),
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Wishes",
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
          children: [
            SizedBox(height: 8),

            /// 🔹 Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: chips.map((chip) {
                    final bool isSelected = selectedChip == chip;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
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

            /// 🔹 Wishes List
            Expanded(
              child: wishes.isEmpty
                  ? Center(child: Text("No wishes for this category"))
                  : ListView.builder(
                      itemCount: wishes.length,
                      itemBuilder: (context, index) {
                        final item = wishes[index];

                        return CustomWishesCard(
                          label: item["type"]!,
                          description: item["wish"]!,
                          onAdd: () {
                            /// ✅ Auto-fill wish in AddReminder
                            reminderCtrl.wishController.text = item["wish"]!;
                            reminderCtrl.wish.value = item["wish"]!;

                            /// ✅ Optional: auto-fill reminder type
                            reminderCtrl.reminderTypeController.text =
                                item["type"]!;
                            reminderCtrl.reminderType.value = item["type"]!;

                            /// Go back to AddReminder
                            Get.back();
                          },
                        );
                      },
                    ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
