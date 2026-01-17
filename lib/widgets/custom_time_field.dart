// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

TextEditingController timeController = TextEditingController();

Widget timeField(BuildContext context) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: timeController,
      readOnly: true,
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
    
        if (picked != null) {
          timeController.text = picked.format(context);
        }
      },
      decoration: InputDecoration(
        hintText: "Time",
        prefixIcon: Icon(Icons.access_time, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
