import 'package:cloud_firestore/cloud_firestore.dart';

// Status flow:
// pending → quoted → user_approved → completed
//         → rejected (by company)
//         → user_rejected (by user after quote)
const String rfqPending = 'pending';
const String rfqQuoted = 'quoted';
const String rfqUserApproved = 'user_approved';
const String rfqUserRejected = 'user_rejected';
const String rfqCompleted = 'completed';
const String rfqRejected = 'rejected';

class RfqModel {
  String id;
  final String companyId;
  final String companyName;
  String? userId;
  final String projectTitle;
  final String details;
  String status;
  final DateTime createdAt;
  double? quotedPrice; // Price offered by company
  String? companyNote; // Note attached to the quote

  RfqModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    this.userId,
    required this.projectTitle,
    required this.details,
    this.status = rfqPending,
    required this.createdAt,
    this.quotedPrice,
    this.companyNote,
  });

  factory RfqModel.fromMap(Map<String, dynamic> map, String documentId) {
    return RfqModel(
      id: documentId,
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      userId: map['userId'] ?? '',
      projectTitle: map['projectTitle'] ?? '',
      details: map['details'] ?? '',
      status: map['status'] ?? rfqPending,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      quotedPrice: (map['quotedPrice'] as num?)?.toDouble(),
      companyNote: map['companyNote'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'userId': userId,
      'projectTitle': projectTitle,
      'details': details,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      if (quotedPrice != null) 'quotedPrice': quotedPrice,
      if (companyNote != null) 'companyNote': companyNote,
    };
  }
}
