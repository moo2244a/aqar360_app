import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandDetails extends PropertyDetails {
  String? zoning;
  double? streetWidth;

  bool isCorner;
  bool onMainStreet;

  bool hasWater;
  bool hasElectricity;
  bool hasSewage;

  LandDetails({
    this.zoning = "سكني",
    this.streetWidth,
    this.isCorner = false,
    this.onMainStreet = false,
    this.hasWater = false,
    this.hasElectricity = false,
    this.hasSewage = false,
    super.title,
    super.propertyType = PropertyType.land,
    super.imagesUrl,
    super.imagesDocUrl,
    super.propertyDetails,
    super.createdAt,
    super.area,
    super.price,
    super.agreedPrice,
    super.location,
    super.isForSale,
    super.status,
    super.isFavorite,
    super.ownerId,
    super.id,
    super.rejectionReason,
    super.buyerId,
  });

  // 🔥 fromJson صح
  static LandDetails fromJson(Map<String, dynamic> json) {
    return LandDetails(
      title: json['title'] ?? '',
      imagesUrl: List<String>.from(json['imagesUrl'] ?? []),
      imagesDocUrl: List<String>.from(json['imagesDocUrl'] ?? []),
      propertyDetails: json['propertyDetails'] ?? '',
      propertyType: PropertyType.values.byName(json['type'] ?? 'land'),
      area: (json['area'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      agreedPrice: (json['agreedPrice'] as num?)?.toDouble(),
      location: json['location'] ?? '',
      isForSale: json['isForSale'] ?? true,
      status: PropertyStatus.values.byName(json['status']),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      zoning: json['zoning'] ?? "سكني",
      streetWidth: (json['streetWidth'] ?? 0).toDouble(),
      isCorner: json['isCorner'] ?? false,
      onMainStreet: json['onMainStreet'] ?? false,
      hasWater: json['hasWater'] ?? false,
      hasElectricity: json['hasElectricity'] ?? false,
      hasSewage: json['hasSewage'] ?? false,
      ownerId: json["ownerId"],
      buyerId: json["buyerId"],
      id: json['id'],
      rejectionReason: json['rejectionReason'],
    );
  }

  // 🔥 toJson صح
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagesUrl': imagesUrl,
      'imagesDocUrl': imagesDocUrl,
      'propertyDetails': propertyDetails,
      'area': area,
      'price': price,
      'agreedPrice': agreedPrice,
      'location': location,
      'isForSale': isForSale,
      'status': status.name,
      "ownerId": ownerId,
      'type': propertyType!.name,
      'zoning': zoning,
      'streetWidth': streetWidth,
      'isCorner': isCorner,
      'onMainStreet': onMainStreet,
      'hasWater': hasWater,
      'hasElectricity': hasElectricity,
      'hasSewage': hasSewage,
      "createdAt": FieldValue.serverTimestamp(),
      'id': id,
      'rejectionReason': rejectionReason,
      'buyerId': buyerId,
    };
  }

  @override
  LandDetails copyWithBase({
    int? bedrooms,
    int? bathrooms,
    int? livingRooms,
    String? title,
    String? propertyDetails,
    List<String>? imagesUrl,
    List<String>? imagesDocUrl,
    double? area,
    double? price,
    double? agreedPrice,
    String? location,
    PropertyType? propertyType,
    bool? isForSale,
    bool? isFavorite,
    PropertyStatus? status,
    String? ownerId,
    FieldValue? createdAt,
    String? zoning,
    double? streetWidth,
    bool? isCorner,
    bool? onMainStreet,
    bool? hasWater,
    bool? hasElectricity,
    bool? hasSewage,
    String? id,
    String? rejectionReason,
    String? buyerId,
  }) {
    return LandDetails(
      zoning: zoning ?? this.zoning,
      streetWidth: streetWidth ?? this.streetWidth,
      isCorner: isCorner ?? this.isCorner,
      onMainStreet: onMainStreet ?? this.onMainStreet,
      hasWater: hasWater ?? this.hasWater,
      hasElectricity: hasElectricity ?? this.hasElectricity,
      hasSewage: hasSewage ?? this.hasSewage,
      title: title ?? this.title,
      propertyDetails: propertyDetails ?? this.propertyDetails,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      imagesDocUrl: imagesDocUrl ?? this.imagesDocUrl,
      area: area ?? this.area,
      price: price ?? this.price,
      agreedPrice: agreedPrice ?? this.agreedPrice,
      location: location ?? this.location,
      isForSale: isForSale ?? this.isForSale,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,

      propertyType: propertyType ?? this.propertyType,
      id: id ?? this.id,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      buyerId: buyerId ?? this.buyerId,
    );
  }
}
