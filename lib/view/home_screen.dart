// ignore_for_file: deprecated_member_use

import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/widgets/custom_reminder_card.dart';
import 'package:birthdaycounter/widgets/custom_search_bar.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_drawer.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/widgets/popup/custom_comming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ReminderController reminderCtrl = Get.put(ReminderController());

  String selectedChip = "All"; // top chips selection
  String selectedFilter = "All"; // bottom sheet filter selection
  List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];
  List<String> filters = ["All", "Today", "Upcoming Week", "Upcoming Month"];
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                width: 42,
                height: 42,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.yellow, width: 2),
                ),
                child: Center(
                  child: Icon(Icons.menu, color: AppColors.primary),
                ),
              ),
            );
          },
        ),
        title: Text(
          "Birthday Reminder",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              showComingSoonDialog(context);
            },

            child: Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.yellow, width: 2),
              ),
              child: Center(child: Image.asset("assets/king.png")),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          // Top Chips
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
          const SizedBox(height: 5),
          // Search bar and filter icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showFilterBottomSheet(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/filtericon.svg",
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          // Reminder Cards
          Expanded(
            child: Obx(() {
              // Start from filteredReminders as base
              List reminders = List.from(reminderCtrl.filteredReminders);

              // Apply top chip filter
              if (selectedChip != "All") {
                reminders = reminders
                    .where((r) => r.reminderType == selectedChip)
                    .toList();
              }

              // Apply bottom sheet filter
              final now = DateTime.now();
              if (selectedFilter == "Today") {
                reminders = reminders.where((r) {
                  final d = reminderCtrl.combineDateTime(r.date, r.time);
                  return d.year == now.year &&
                      d.month == now.month &&
                      d.day == now.day;
                }).toList();
              } else if (selectedFilter == "Upcoming Week") {
                final start = now.add(Duration(days: 1));
                final end = now.add(Duration(days: 7));
                reminders = reminders.where((r) {
                  final d = reminderCtrl.combineDateTime(r.date, r.time);
                  return d.isAfter(start.subtract(Duration(seconds: 1))) &&
                      d.isBefore(end.add(Duration(days: 1)));
                }).toList();
              } else if (selectedFilter == "Upcoming Month") {
                final endOfMonth = DateTime(now.year, now.month + 1, 0);
                reminders = reminders.where((r) {
                  final d = reminderCtrl.combineDateTime(r.date, r.time);
                  return d.isAfter(now.subtract(Duration(seconds: 1))) &&
                      d.isBefore(endOfMonth.add(Duration(days: 1)));
                }).toList();
              }

              // Apply search filter
              if (searchText.isNotEmpty) {
                reminders = reminders.where((r) {
                  final name = r.name.toLowerCase();
                  final type = r.reminderType.toLowerCase();
                  return name.contains(searchText) || type.contains(searchText);
                }).toList();
              }

              if (reminders.isEmpty) {
                return Center(child: Image.asset("assets/fileimg.png"));
              }

              return ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return CustomReminderCard(reminder: reminders[index]);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF9B8CE6), AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: () {
            Get.toNamed(AppRoutesName.addReminder);
          },
          child: Icon(Icons.add, color: AppColors.white, size: 30),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filter Reminders",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              // Vertical list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    String filter = filters[index];
                    bool isSelected = selectedFilter == filter;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.black.withOpacity(0.1),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                filter == "Today"
                                    ? Icons.today
                                    : filter == "Upcoming Week"
                                    ? Icons.date_range
                                    : filter == "Upcoming Month"
                                    ? Icons.calendar_month
                                    : Icons.clear_all,
                                size: 24,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.grey,
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
