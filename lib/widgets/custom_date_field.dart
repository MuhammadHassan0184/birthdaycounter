import 'package:flutter/material.dart';

TextEditingController dateController = TextEditingController();

Widget dateField(BuildContext context) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: dateController,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
    
        if (picked != null) {
          dateController.text = "${picked.month}/${picked.day}/${picked.year}";
        }
      },
      decoration: InputDecoration(
        hintText: "MM/DD/YYYY",
        prefixIcon: Icon(Icons.calendar_month, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
