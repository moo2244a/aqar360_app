import 'package:aqar360/app/features/addProperty/presentation/screens/edit_property_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqar360/app/core/models/notification_model.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'الإشعارات',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: StreamBuilder<List<NotificationModel>>(
          stream: FirebaseHelper.getUserNotifications(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }

            final notifications = snapshot.data ?? [];

            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد إشعارات حالياً',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationItem(context, notif);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationModel notif) {
    final bool isRejected = notif.type == 'rejected_property';

    return Container(
      color: notif.isRead ? Colors.transparent : Colors.blue.withOpacity(0.05),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isRejected
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isRejected ? Icons.error_outline : Icons.check_circle_outline,
            color: isRejected ? Colors.red : Colors.green,
          ),
        ),
        title: Text(
          notif.title,
          style: TextStyle(
            fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            notif.body,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        onTap: () async {
          if (!notif.isRead) {
            await FirebaseHelper.markNotificationAsRead(notif.id);
          }

          if (isRejected && notif.relatedId != null) {
            // Fetch property and navigate to Edit Screen
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );

            final property = await FirebaseHelper.getPropertyById(
              notif.relatedId!,
            );
            Navigator.pop(context); // close dialog

            if (property != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPropertyScreen(property: property),
                ),
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('العقار غير موجود')));
            }
          }
        },
      ),
    );
  }
}
