import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDealMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime createdAt;

  PropertyDealMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory PropertyDealMessage.fromMap(Map<String, dynamic> map, String docId) {
    return PropertyDealMessage(
      id: docId,
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'text': text,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
