import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  final List<Map<String, String>> notifications = [
    {
      "title": "Medication Reminder",
      "message": "Time to take your blood pressure medication.",
      "time": "10 minutes ago"
    },
    {
      "title": "Clinic Visit Reminder",
      "message": "You have a clinic appointment tomorrow at 09:00.",
      "time": "1 hour ago"
    },
    {
      "title": "Missed Medication",
      "message": "You haven't taken your Vitamin C yet.",
      "time": "Today"
    },
  ];

  void clearNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xFF1F6F68),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: clearNotifications,
          )
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
        child: Text(
          "No notifications yet",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(
                Icons.notifications_active,
                color: Color(0xFF1F6F68),
                size: 30,
              ),
              title: Text(
                item["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["message"]!),
              trailing: Text(
                item["time"]!,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}