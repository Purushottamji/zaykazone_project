import 'package:flutter/cupertino.dart';

class AppNotification {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  bool isRead;

  AppNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    this.isRead = false,
  });
}
