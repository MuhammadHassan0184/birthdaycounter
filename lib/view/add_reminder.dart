import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/widgets/Custom_Secondry_Field.dart';
import 'package:birthdaycounter/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: Text(
          "Birthday Reminder",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer Circle
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                ),
                // Middle Circle
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                ),
                // Inner Circle with Image
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/my.jpg"), // or NetworkImage
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Bottom overlay icon
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.image, // replace with your desired icon
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: CustomSecondryField(label: "Full Name", icon: Icons.person_2),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: CustomSecondryField(label: "Phone (Optional)", icon: Icons.call),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: CustomSecondryField(label: "Email (Optional)", icon: Icons.email),
          // ),
        ],
      ),
    );
  }
}
