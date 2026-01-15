// ignore_for_file: must_be_immutable

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  VoidCallback? onTap;
   CustomButton({
    super.key,
    required this.label,
     this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(AppColors.primary) ,
                ),
                onPressed: onTap, 
                child: Text(label, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                ),
            ),
          );
  }
}