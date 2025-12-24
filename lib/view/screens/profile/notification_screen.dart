import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../model/notification_model/app_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const accentColor = Color(0xffFF620D);

  final List<AppNotification> notifications = [
    AppNotification(
      title: "Order Delivered",
      message: "Your order #234 was delivered successfully.",
      time: "10 mins ago",
      icon: Icons.check_circle,
    ),
    AppNotification(
      title: "New Offer!",
      message: "Get 20% OFF on Pizza Hut orders.",
      time: "1 hour ago",
      icon: Icons.local_offer,
    ),
    AppNotification(
      title: "Order Shipped",
      message: "Your order is on the way!",
      time: "2 hours ago",
      icon: Icons.delivery_dining,
    ),
    AppNotification(
      title: "Wallet Update",
      message: "₹150 added to your wallet.",
      time: "Yesterday",
      icon: Icons.account_balance_wallet,
      isRead: true,
    ),
  ];

  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Notifications"),
            const SizedBox(width: 8),

            if (unreadCount > 0)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: notifications.isEmpty
            ? _emptyState()
            : Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(
              w * 0.05,
              kToolbarHeight + 20,
              w * 0.05,
              20,
                        ),
                        itemCount: notifications.length,
                        itemBuilder: (_, index) {
              final n = notifications[index];

              return Dismissible(
                key: ValueKey(n.title + n.time),
                background: _swipeLeftBg(),
                secondaryBackground: _swipeRightBg(),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // ➡ Mark as read
                    setState(() => n.isRead = true);
                    return false;
                  }
                  return true;
                },
                onDismissed: (_) {
                  setState(() => notifications.removeAt(index));
                },
                child: _notificationTile(n),
              );
                        },
                      ),
            ),
      ),
    );
  }

  Widget _notificationTile(AppNotification n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: n.isRead
                  ? Colors.white.withOpacity(0.10)
                  : Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔴 Unread Dot
                if (!n.isRead)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),

                if (!n.isRead) const SizedBox(width: 6),

                CircleAvatar(
                  radius: 22,
                  backgroundColor: accentColor.withOpacity(0.2),
                  child: Icon(n.icon, color: accentColor),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          n.isRead ? FontWeight.w500 : FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.message,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n.time,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ➡ Swipe Right → Mark Read
  Widget _swipeLeftBg() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.done, color: Colors.white),
    );
  }

  /// ⬅ Swipe Left → Delete
  Widget _swipeRightBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  /// 📭 Empty State
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.white54),
          SizedBox(height: 12),
          Text(
            "No notifications",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
