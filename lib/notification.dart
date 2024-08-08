import 'package:flutter/material.dart';

//notification
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of notifications (replace with actual data fetching logic)
    List<String> notifications = ['Notification 1', 'Notification 2'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            onTap: () {
              // Handle tap on notification item
              print('Tapped on notification: ${notifications[index]}');
            },
          );
        },
      ),
    );
  }
}
