// ignore_for_file: depend_on_referenced_packages, unnecessary_import, avoid_print, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

// Dummy CropController (replace with your actual crop logic)
class CropController {
  Future<String?> cropImage(String imagePath, {required BuildContext context}) async {
    // Implement your cropping logic here
    return imagePath; // placeholder
  }
}

class ImagePickerController {
  Uint8List? webImageBytes; // For Web
  String? imagePath;         // For Mobile
  final TextEditingController imageCtrl = TextEditingController();
  final CropController cropCtrl = CropController();

  /// Pick image from gallery and optionally crop
  Future<void> pick(BuildContext context, {bool crop = true}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        print("Image picking cancelled");
        return;
      }

      if (kIsWeb) {
        // Web: read bytes
        webImageBytes = await pickedFile.readAsBytes();
        imageCtrl.text = path.basename(pickedFile.name);

        if (crop) {
          final croppedPath = await cropCtrl.cropImage(pickedFile.path, context: context);
          print("Web cropped path: $croppedPath");
        }

        print("Web image picked: ${imageCtrl.text}");
      } else {
        // Mobile
        String filePath = pickedFile.path;

        if (crop) {
          final croppedPath = await cropCtrl.cropImage(filePath, context: context);
          if (croppedPath != null) filePath = croppedPath;
        }

        imagePath = filePath;
        imageCtrl.text = path.basename(imagePath!);

        print("Mobile image picked: ${imageCtrl.text}");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
