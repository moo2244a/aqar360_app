import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VillaDetails extends PropertyDetails {
  int floors;
  bool hasPool;
  bool hasGarden;
  bool hasGarage;

  VillaDetails({
    this.floors = 1,
    this.hasPool = false,
    this.hasGarden = false,
    this.hasGarage = false,
    super.createdAt,
    super.bedrooms,
    super.bathrooms,
    super.livingRooms,
    super.propertyType = PropertyType.villa,
    super.title,
    super.imagesUrl,
    super.imagesDocUrl,
    super.propertyDetails,
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

  // ✅ fromJson الصح
  static VillaDetails fromJson(Map<String, dynamic> json) {
    return VillaDetails(
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      livingRooms: json['livingRooms'] ?? 0,

      title: json['title'] ?? '',
      imagesUrl: List<String>.from(json['imagesUrl'] ?? []),
      imagesDocUrl: List<String>.from(json['imagesDocUrl'] ?? []),
      propertyDetails: json['propertyDetails'] ?? '',
      propertyType: PropertyType.values.byName(json['type'] ?? 'villa'),
      area: (json['area'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      agreedPrice: (json['agreedPrice'] as num?)?.toDouble(),
      location: json['location'] ?? '',
      isForSale: json['isForSale'] ?? true,
      status: PropertyStatus.values.byName(json['status']),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      floors: json['floors'] ?? 1,
      hasPool: json['hasPool'] ?? false,
      hasGarden: json['hasGarden'] ?? false,
      hasGarage: json['hasGarage'] ?? false,
      ownerId: json["ownerId"],
      buyerId: json["buyerId"],
      id: json['id'],
      rejectionReason: json['rejectionReason'],
    );
  }

  // ✅ toJson الصح
  @override
  Map<String, dynamic> toJson() {
    return {
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'livingRooms': livingRooms,
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
      "createdAt": FieldValue.serverTimestamp(),
      'floors': floors,
      'hasPool': hasPool,
      'hasGarden': hasGarden,
      'hasGarage': hasGarage,
      'id': id,
      'rejectionReason': rejectionReason,
      'buyerId': buyerId,
    };
  }

  @override
  VillaDetails copyWithBase({
    // Base fields
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
    String? id,
    String? rejectionReason,
    String? buyerId,
    // Villa-specific fields
    int? floors,
    bool? hasPool,
    bool? hasGarden,
    bool? hasGarage,
  }) {
    return VillaDetails(
      floors: floors ?? this.floors,
      hasPool: hasPool ?? this.hasPool,
      hasGarden: hasGarden ?? this.hasGarden,
      hasGarage: hasGarage ?? this.hasGarage,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      livingRooms: livingRooms ?? this.livingRooms,
      title: title ?? this.title,
      propertyDetails: propertyDetails ?? this.propertyDetails,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      imagesDocUrl: imagesDocUrl ?? this.imagesDocUrl,
      area: area ?? this.area,
      price: price ?? this.price,
      agreedPrice: agreedPrice ?? this.agreedPrice,
      location: location ?? this.location,
      propertyType: propertyType ?? this.propertyType,
      isForSale: isForSale ?? this.isForSale,
      isFavorite: isFavorite ?? this.isFavorite,
      id: id ?? this.id,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
      buyerId: buyerId ?? this.buyerId,
    );
  }
}
