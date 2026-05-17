import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentDetails extends PropertyDetails {
  int floorNumber;
  int totalFloors;
  bool hasElevator;
  bool hasParking;
  bool hasSecurity;
  bool hasBalcony;

  ApartmentDetails({
    super.bedrooms,
    super.bathrooms,
    super.livingRooms,
    super.title,
    super.createdAt,
    super.imagesUrl,
    super.imagesDocUrl,
    super.propertyDetails,
    super.area,
    super.price,
    super.location,
    super.isForSale,
    super.status,
    super.propertyType = PropertyType.apartment,
    this.floorNumber = 1,
    this.totalFloors = 1,
    this.hasElevator = false,
    this.hasParking = false,
    this.hasSecurity = false,
    this.hasBalcony = false,
    super.isFavorite,
    super.ownerId,
    super.id,
    super.agreedPrice,
    super.rejectionReason,
    super.buyerId,
  });
  static ApartmentDetails fromJson(Map<String, dynamic> json) {
    return ApartmentDetails(
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      livingRooms: json['livingRooms'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      title: json['title'] ?? '',
      imagesUrl: List<String>.from(json['imagesUrl'] ?? []),
      imagesDocUrl: List<String>.from(json['imagesDocUrl'] ?? []),
      propertyDetails: json['propertyDetails'] ?? '',
      propertyType: propertyTypeFromString(json['type']),
      area: (json['area'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      agreedPrice: (json['agreedPrice'] as num?)?.toDouble(),
      location: json['location'] ?? '',
      isForSale: json['isForSale'] ?? true,
      status: PropertyStatus.values.byName(json['status']),
      floorNumber: json['floorNumber'] ?? 1,
      totalFloors: json['totalFloors'] ?? 1,
      hasElevator: json['hasElevator'] ?? false,
      hasParking: json['hasParking'] ?? false,
      hasSecurity: json['hasSecurity'] ?? false,
      hasBalcony: json['hasBalcony'] ?? false,
      ownerId: json["ownerId"],
      buyerId: json["buyerId"],
      id: json['id'],
      rejectionReason: json['rejectionReason'],
    );
  }

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
      'floorNumber': floorNumber,
      'totalFloors': totalFloors,
      'hasElevator': hasElevator,
      'hasParking': hasParking,
      'hasSecurity': hasSecurity,
      'hasBalcony': hasBalcony,
      'id': id,
      'rejectionReason': rejectionReason,
      'buyerId': buyerId,
    };
  }

  @override
  ApartmentDetails copyWithBase({
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
    String? buyerId,
    // Apartment-specific fields
    int? floorNumber,
    int? totalFloors,
    bool? hasElevator,
    bool? hasParking,
    bool? hasSecurity,
    bool? hasBalcony,
    String? id,
    String? rejectionReason,
  }) {
    return ApartmentDetails(
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
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,

      floorNumber: floorNumber ?? this.floorNumber,
      totalFloors: totalFloors ?? this.totalFloors,
      hasElevator: hasElevator ?? this.hasElevator,
      hasParking: hasParking ?? this.hasParking,
      hasSecurity: hasSecurity ?? this.hasSecurity,
      hasBalcony: hasBalcony ?? this.hasBalcony,
      id: id ?? this.id,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      buyerId: buyerId ?? this.buyerId,
    );
  }
}
