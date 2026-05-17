import 'package:cloud_firestore/cloud_firestore.dart';

// Offer status constants
const String offerPending = 'pending';
const String offerAccepted = 'accepted';
const String offerRejected = 'rejected';
const String offerCountered = 'countered';

class PropertyOfferModel {
  String id;
  final String propertyId;
  final String propertyTitle;
  final String buyerId;
  final String buyerName;
  final String ownerId;
  final double offeredPrice;
  final bool isForSale;
  double? counterPrice;
  String status;
  String? ownerNote;
  final DateTime createdAt;

  PropertyOfferModel({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.buyerId,
    required this.buyerName,
    required this.ownerId,
    required this.offeredPrice,
    required this.isForSale,
    this.counterPrice,
    this.status = offerPending,
    this.ownerNote,
    required this.createdAt,
  });

  factory PropertyOfferModel.fromMap(Map<String, dynamic> map, String docId) {
    return PropertyOfferModel(
      id: docId,
      propertyId: map['propertyId'] ?? '',
      propertyTitle: map['propertyTitle'] ?? '',
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
      ownerId: map['ownerId'] ?? '',
      offeredPrice: (map['offeredPrice'] as num?)?.toDouble() ?? 0.0,
      isForSale: map['isForSale'] ?? true,
      counterPrice: (map['counterPrice'] as num?)?.toDouble(),
      status: map['status'] ?? offerPending,
      ownerNote: map['ownerNote'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'ownerId': ownerId,
      'offeredPrice': offeredPrice,
      'isForSale': isForSale,
      if (counterPrice != null) 'counterPrice': counterPrice,
      'status': status,
      if (ownerNote != null) 'ownerNote': ownerNote,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
