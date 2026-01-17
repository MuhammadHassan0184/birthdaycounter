// lib/widgets/profile_image_picker.dart

// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:birthdaycounter/controllers/image_picker_controller.dart';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatefulWidget {
  final ImagePickerController controller;
  const ProfileImagePicker({super.key, required this.controller});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: widget.controller.webImageBytes != null
                    ? MemoryImage(widget.controller.webImageBytes!)
                    : (widget.controller.imagePath != null
                        ? FileImage(File(widget.controller.imagePath!))
                        :  AssetImage("assets/imageicon.png")) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                await widget.controller.pick(context, crop: true);
                setState(() {}); // Refresh UI after picking
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                child:  Icon(Icons.image, color: Colors.blue, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
