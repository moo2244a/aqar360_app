import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  final String userId;
  final String title;
  final String body;
  final DateTime createdAt;
  bool isRead;
  final String? type; // e.g. "rejected_property", "accepted_property"
  final String? relatedId; // e.g. propertyId

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.type,
    this.relatedId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String documentId) {
    return NotificationModel(
      id: documentId,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: map['isRead'] ?? false,
      type: map['type'],
      relatedId: map['relatedId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'createdAt': Timestamp.fromDate(createdAt),
      'isRead': isRead,
      'type': type,
      'relatedId': relatedId,
    };
  }
}
