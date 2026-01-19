// ignore_for_file: unnecessary_import

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/widgets/custom_drawer.dart';
import 'package:birthdaycounter/widgets/custom_reminder_card.dart';
import 'package:birthdaycounter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedChip = "All"; // default selected
  List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,

        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
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
                child: Center(
                  child: Icon(Icons.menu, color: AppColors.primary),
                ),
              ),
            );
          },
        ),

        title: Text(
          "Birthday Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,

        actions: [
          Container(
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
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 10),
          // chips
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
          SizedBox(height: 10),
          // searchBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(child: CustomSearchBar()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu_open_sharp,
                    color: AppColors.grey,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // remindercard
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CustomReminderCard();
              },
            ),
          ),
          SizedBox(height: 5,),
          // Expanded(child: Center(child: Image.asset("assets/fileimg.png")))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white, size: 30),
        onPressed: () {
          Get.toNamed(AppRoutesName.addReminder);
        },
      ),
    );
  }
}
