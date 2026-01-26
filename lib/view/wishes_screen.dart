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
            SizedBox(height: 5),
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
                            side: BorderSide(
                              color: AppColors.grey.withOpacity(0.2),
                              width: 1,
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
            // wishescard
            Expanded(
              child: Obx(() {
                if (reminderCtrl.reminders.isEmpty) {
                  return const Center(child: Text("No wishes added yet"));
                }

                // Optional: chip filter
                final filteredReminders = selectedChip == "All"
                    ? reminderCtrl.reminders
                    : reminderCtrl.reminders
                          .where((r) => r.reminderType == selectedChip)
                          .toList();

                if (filteredReminders.isEmpty) {
                  return const Center(
                    child: Text("No wishes for this category"),
                  );
                }

                return ListView.builder(
                  itemCount: filteredReminders.length,
                  itemBuilder: (context, index) { 
                    final reminder = filteredReminders[index];

                    return CustomWishesCard(
                      label: reminder.reminderType, //  Reminder Type
                      description: reminder.wish, // Wish text
                      onAdd: () {
                        final reminderCtrl = Get.find<ReminderController>();

                        // set wish value
                        reminderCtrl.wishController.text = reminder.wish;
                        reminderCtrl.wish.value = reminder.wish;

                        // go back to AddReminder
                        Get.back();
                      },
                    );
                  },
                );
              }),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
