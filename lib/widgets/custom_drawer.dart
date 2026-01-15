import 'package:flutter/material.dart';
import 'package:birthdaycounter/config/Colors/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.clean_hands_rounded, color: AppColors.primary,),
            title: Text("Celebrities", style: TextStyle(fontWeight: FontWeight.bold,),),
            onTap: () {
               
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_sharp, color: AppColors.primary),
            title: Text("Support", style: TextStyle(fontWeight: FontWeight.bold,)),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
