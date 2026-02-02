// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission {
  static Future<void> request(BuildContext context) async {
    if (!Platform.isAndroid) return;

    final status = await Permission.notification.status;

    if (status.isDenied || status.isRestricted) {
      final result = await Permission.notification.request();

      if (!result.isGranted) {
        _showSettingsDialog(context);
      }
    }
  }

  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Enable Notifications 🔔"),
        content: const Text(
          "Notifications help remind you about birthdays and special events.",
        ),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }
}
