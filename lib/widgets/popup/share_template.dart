// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:birthdaycounter/config/Colors/colors.dart';

class ReminderShareCard extends StatefulWidget {
  const ReminderShareCard({super.key});

  @override
  State<ReminderShareCard> createState() => _ReminderShareCardState();
}

class _ReminderShareCardState extends State<ReminderShareCard> {
  final GlobalKey repaintKey = GlobalKey();
  late Map<String, dynamic> reminder;

  @override
  void initState() {
    super.initState();
    reminder = Get.arguments ?? {};
  }

  /// 📸 CAPTURE CARD AS IMAGE
  Future<Uint8List> _captureImage() async {
    final boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// 📤 SHARE IMAGE
  // ...

  Future<void> shareImage() async {
    final bytes = await _captureImage();

    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/reminder.png');

    // Save the image
    await file.writeAsBytes(bytes);

    // Share
    await Share.shareXFiles([
      XFile(file.path),
    ], text: "🎉 Reminder shared from Birthday Counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text("Share Reminder", style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),

          /// 📷 CARD PREVIEW
          RepaintBoundary(
            key: repaintKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildResponsiveCard(context),
            ),
          ),

          Spacer(),

          /// SHARE BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: shareImage,
              child: Container(
                height: 50, // button height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.4), // light purple
                      AppColors.primary, // dark purple
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.share, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🎨 RESPONSIVE UNIQUE CARD
  Widget _buildResponsiveCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(reminder['name']),
                _sub(reminder['relationship']),
                const SizedBox(height: 12),

                _row(Icons.cake, reminder['date']),
                _row(
                  Icons.category,
                  reminder['reminderType'],
                ), // NEW REMINDER TYPE ROW
                _row(Icons.phone, reminder['phone']),
                _row(Icons.email, reminder['email']),

                SizedBox(height: 14),

                /// 💌 WISH
                if (reminder['wish'] != null &&
                    reminder['wish'].toString().isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Message",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          reminder['wish'],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 10),

                Center(
                  child: Text(
                    "Shared via Birthday Counter 🎉",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String? text) {
    return Text(
      text ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _sub(String? text) {
    return Text(
      text ?? '',
      style: const TextStyle(color: Colors.white70, fontSize: 14),
    );
  }

  Widget _row(IconData icon, String? text) {
    if (text == null || text.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
