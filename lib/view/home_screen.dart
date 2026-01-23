// // ignore_for_file: unnecessary_import, deprecated_member_use

// import 'package:birthdaycounter/Services/reminder_service.dart';
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:birthdaycounter/controllers/reminder_controller.dart';
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:birthdaycounter/widgets/custom_drawer.dart';
// import 'package:birthdaycounter/widgets/custom_reminder_card.dart';
// import 'package:birthdaycounter/widgets/custom_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/instance_manager.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ReminderController reminderCtrl = Get.put(ReminderController());
//   String selectedChip = "All"; // default selected
//   List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];

//   final ReminderService reminderService = ReminderService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       drawer: CustomDrawer(),
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,

//         leading: Builder(
//           builder: (context) {
//             return GestureDetector(
//               onTap: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               child: Container(
//                 width: 42,
//                 height: 42,
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: AppColors.yellow, width: 2),
//                 ),
//                 child: Center(
//                   child: Icon(Icons.menu, color: AppColors.primary),
//                 ),
//               ),
//             );
//           },
//         ),

//         title: Text(
//           "Birthday Reminder",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
//         ),
//         centerTitle: true,

//         actions: [
//           Container(
//             width: 42,
//             height: 42,
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               shape: BoxShape.circle,
//               border: Border.all(color: AppColors.yellow, width: 2),
//             ),
//             child: Center(child: Image.asset("assets/king.png")),
//           ),
//         ],
//       ),

//       body: Column(
//         children: [
//           SizedBox(height: 5),
//           // chips
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 children: chips.map((chip) {
//                   bool isSelected = selectedChip == chip;
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedChip = chip;
//                         });
//                       },
//                       child: Chip(
//                         label: Text(
//                           chip,
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : AppColors.grey,
//                           ),
//                         ),
//                         backgroundColor: isSelected
//                             ? AppColors.primary
//                             : Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           side: BorderSide(
//                             color: AppColors.grey.withOpacity(0.2),
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           // searchBar
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 Expanded(child: CustomSearchBar()),
//                 IconButton(
//                   onPressed: () {
//                     // your action here
//                   },
//                   icon: SvgPicture.asset(
//                     "assets/filtericon.svg", //  your SVG file
//                     width: 30,
//                     height: 30,
//                     colorFilter: ColorFilter.mode(
//                       AppColors
//                           .black, // optional, applies color to monochrome SVG
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 7),
//           // remindercard
//           Expanded(
//             child: StreamBuilder<List<Reminder>>(
//               stream: reminderCtrl.getReminders(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Expanded(
//                     child: Center(child: Image.asset("assets/fileimg.png")),
//                   );
//                 }

//                 final reminders = snapshot.data!;

//                 if (reminders.isEmpty) {
//                   return Center(child: Image.asset("assets/fileimg.png"));
//                 }

//                 return ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: reminders.length,
//                   itemBuilder: (context, index) {
//                     return CustomReminderCard(reminder: reminders[index]);
//                   },
//                 );
//               },
//             ),
//           ),

//           SizedBox(height: 5),
//           // Expanded(child: Center(child: Image.asset("assets/fileimg.png")))
//         ],
//       ),
//       floatingActionButton: Container(
//         width: 60, // adjust size
//         height: 60,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF9B8CE6),
//               AppColors.primary,
//             ], // your gradient colors
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: RawMaterialButton(
//           shape: CircleBorder(),
//           onPressed: () {
//             Get.toNamed(AppRoutesName.addReminder);
//           },
//           child: Icon(Icons.add, color: AppColors.white, size: 30),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: unnecessary_import, deprecated_member_use

import 'package:birthdaycounter/Services/reminder_service.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:birthdaycounter/controllers/reminder_controller.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:birthdaycounter/widgets/custom_drawer.dart';
import 'package:birthdaycounter/widgets/custom_reminder_card.dart';
import 'package:birthdaycounter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ReminderController reminderCtrl = Get.put(ReminderController());
  String selectedChip = "All"; // default selected
  List<String> chips = ["All", "Birthday", "Engagement", "Anniversary"];

  final ReminderService reminderService = ReminderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
          SizedBox(height: 5),
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
          // searchBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(child: CustomSearchBar()),
                IconButton(
                  onPressed: () {
                    // your action here
                  },
                  icon: SvgPicture.asset(
                    "assets/filtericon.svg", //  your SVG file
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      AppColors
                          .black, // optional, applies color to monochrome SVG
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7),
          // remindercard
          Expanded(
            child: StreamBuilder<List<Reminder>>(
              stream: ReminderService().getReminders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Image.asset("assets/fileimg.png"));
                }
                // Center(
                //   child: SvgPicture.asset(
                //     "assets/empty.svg",
                //     width: 200, // optional
                //     height: 200, // optional
                //   ),
                // );
                final reminders = snapshot.data!;

                return ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    return CustomReminderCard(reminder: reminders[index]);
                  },
                );
              },
            ),
          ),

          SizedBox(height: 5),
          // Expanded(child: Center(child: Image.asset("assets/fileimg.png")))
        ],
      ),
      floatingActionButton: Container(
        width: 60, // adjust size
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF9B8CE6),
              AppColors.primary,
            ], // your gradient colors
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
}
