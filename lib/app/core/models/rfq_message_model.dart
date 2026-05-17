import 'package:cloud_firestore/cloud_firestore.dart';

class RfqMessageModel {
  String id;
  final String senderId;
  final String text;
  final DateTime createdAt;

  RfqMessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory RfqMessageModel.fromMap(Map<String, dynamic> map, String documentId) {
    return RfqMessageModel(
      id: documentId,
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
