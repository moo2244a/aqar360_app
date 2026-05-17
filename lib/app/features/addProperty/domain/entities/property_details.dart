import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';

abstract class PropertyDetails {
  int bedrooms;
  int bathrooms;
  int livingRooms;
  String? title;
  String? propertyDetails;
  List<String>? imagesUrl;
  List<String>? imagesDocUrl;
  double? area;
  double? price;
  double? agreedPrice;
  String? location;
  PropertyType? propertyType;
  bool isForSale;
  bool isFavorite;
  PropertyStatus status;
  String? ownerId;
  DateTime? createdAt;
  String? id;
  String? rejectionReason;
  String? buyerId;
  PropertyDetails({
    this.isForSale = true,
    this.createdAt,
    this.bedrooms = 1,
    this.bathrooms = 1,
    this.livingRooms = 1,
    this.title,
    this.imagesUrl,
    this.imagesDocUrl,
    this.area,
    this.price,
    this.agreedPrice,
    this.location,
    this.ownerId,
    this.isFavorite = false,
    this.status = PropertyStatus.pending,
    this.propertyDetails,
    this.propertyType,
    this.id,
    this.rejectionReason,
    this.buyerId,
  });
  Map<String, dynamic> toJson();

  static PropertyDetails fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'villa':
        return VillaDetails.fromJson(json);
      case 'apartment':
        return ApartmentDetails.fromJson(json);
      case 'land':
        return LandDetails.fromJson(json);
      default:
        throw Exception("Unknown type");
    }
  }

  PropertyDetails copyWithBase({
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
    String? buyerId,
  });
}
