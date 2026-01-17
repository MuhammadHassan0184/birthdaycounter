// ignore_for_file: unnecessary_import

import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

Widget wishField() {
  return SizedBox(
    height: 50,
    child: TextFormField(
      decoration: InputDecoration(
        hintText: "Wish",
        prefixIcon: Icon(Icons.card_giftcard, color: Colors.deepPurple),
        suffixIcon: IconButton(onPressed: (){
          Get.toNamed(AppRoutesName.wishesScreen);
        }, 
        icon: Icon(Icons.add)
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onChanged: (value) {
        
      },
    ),
  );
}
