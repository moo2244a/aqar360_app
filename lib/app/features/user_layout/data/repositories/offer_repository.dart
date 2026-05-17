import 'package:aqar360/app/features/user_layout/data/models/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendOffer(OfferModel offer) async {
    await _firestore.collection('offers').add(offer.toJson());
  }

  Future<List<OfferModel>> getOffersForProperty(String propertyId) async {
    final querySnapshot = await _firestore
        .collection('offers')
        .where('propertyId', isEqualTo: propertyId)
        .get();

    return querySnapshot.docs.map((doc) {
      return OfferModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<List<OfferModel>> getOffersByOwner(String ownerId) async {
    final querySnapshot = await _firestore
        .collection('offers')
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return querySnapshot.docs.map((doc) {
      return OfferModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<List<OfferModel>> getOffersByBuyer(String buyerId) async {
    final querySnapshot = await _firestore
        .collection('offers')
        .where('buyerId', isEqualTo: buyerId)
        .get();

    return querySnapshot.docs.map((doc) {
      return OfferModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<void> updateOfferStatus(String offerId, OfferStatus status) async {
    await _firestore.collection('offers').doc(offerId).update({
      'status': status.name,
    });
  }
}
