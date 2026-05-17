import 'package:cloud_firestore/cloud_firestore.dart';

enum OfferStatus { pending, accepted, rejected }

class OfferModel {
  final String? id;
  final String propertyId;
  final String buyerId;
  final String ownerId;
  final double offeredPrice;
  final OfferStatus status;
  final FieldValue? createdAt;

  OfferModel({
    this.id,
    required this.propertyId,
    required this.buyerId,
    required this.ownerId,
    required this.offeredPrice,
    this.status = OfferStatus.pending,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'buyerId': buyerId,
      'ownerId': ownerId,
      'offeredPrice': offeredPrice,
      'status': status.name,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory OfferModel.fromJson(Map<String, dynamic> json, String id) {
    return OfferModel(
      id: id,
      propertyId: json['propertyId'] ?? '',
      buyerId: json['buyerId'] ?? '',
      ownerId: json['ownerId'] ?? '',
      offeredPrice: (json['offeredPrice'] ?? 0).toDouble(),
      status: OfferStatus.values.byName(json['status'] ?? 'pending'),
      createdAt: json['createdAt'],
    );
  }
}
